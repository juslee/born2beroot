import http.server
import socketserver
import re

PORT = 8000

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path in ['/preseed.cfg', '/preseed_bonus.cfg']:
            self.send_response(200)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            config_file = self.path.lstrip('/')
            with open(config_file, 'r') as file:
                content = file.read()
                hostname = self.headers['Host'].split(':')[0]
                port = self.headers['Host'].split(':')[1] if ':' in self.headers['Host'] else str(PORT)
                content = re.sub(r'\$SERVER_IP', hostname, content)
                content = re.sub(r'\$SERVER_PORT', port, content)
                self.wfile.write(content.encode())
        else:
            super().do_GET()

if __name__ == '__main__':
    with socketserver.TCPServer(("", PORT), CustomHandler) as httpd:
        print(f"Serving at http://0.0.0.0:{PORT}")
        httpd.serve_forever()
