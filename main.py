import http.server
import socketserver
import json
import mysql.connector

# RESTful API Handler for Charity Donation Management System
class CharityDonationHandler(http.server.SimpleHTTPRequestHandler):

    def _send_response(self, response_data, status_code=200):
        self.send_response(status_code)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(response_data).encode('utf-8'))

    def do_GET(self):
        if self.path.startswith('/donors'):
            self.handle_get_donors()
        elif self.path.startswith('/donations'):
            self.handle_get_donations()
        elif self.path.startswith('/causes'):
            self.handle_get_causes()
        else:
            self._send_response({'error': 'Invalid endpoint'}, status_code=404)

    def handle_get_donors(self):
        connection = self._connect_db()
        cursor = connection.cursor()

        cursor.execute('SELECT * FROM Donors')
        donors = cursor.fetchall()

        response = [{'donor_id': d[0], 'name': d[1], 'email': d[2], 'contact_number': d[3], 'address': d[4]} for d in donors]

        connection.close()
        self._send_response(response)

    def handle_get_donations(self):
        connection = self._connect_db()
        cursor = connection.cursor()

        cursor.execute('SELECT * FROM Donations')
        donations = cursor.fetchall()

        response = [{'donation_id': d[0], 'donor_id': d[1], 'amount': str(d[2]), 'donation_date': str(d[3]), 'cause': d[4]} for d in donations]

        connection.close()
        self._send_response(response)

    def handle_get_causes(self):
        connection = self._connect_db()
        cursor = connection.cursor()

        cursor.execute('SELECT * FROM Causes')
        causes = cursor.fetchall()

        response = [{'cause_id': c[0], 'name': c[1], 'description': c[2]} for c in causes]

        connection.close()
        self._send_response(response)

    def do_POST(self):
        if self.path.startswith('/donors'):
            self.handle_post_donor()
        elif self.path.startswith('/donations'):
            self.handle_post_donation()
        elif self.path.startswith('/causes'):
            self.handle_post_cause()
        else:
            self._send_response({'error': 'Invalid endpoint'}, status_code=404)

    def handle_post_donor(self):
        content_length = int(self.headers['Content-Length'])
        post_data = json.loads(self.rfile.read(content_length))

        connection = self._connect_db()
        cursor = connection.cursor()

        try:
            cursor.execute('INSERT INTO Donors (name, email, contact_number, address) VALUES (%s, %s, %s, %s)',
                           (post_data['name'], post_data['email'], post_data['contact_number'], post_data['address']))
            connection.commit()
            response = {'message': 'Donor added successfully'}
            self._send_response(response, status_code=201)
        except mysql.connector.Error as e:
            self._send_response({'error': str(e)}, status_code=400)
        finally:
            connection.close()

    def handle_post_donation(self):
        content_length = int(self.headers['Content-Length'])
        post_data = json.loads(self.rfile.read(content_length))

        connection = self._connect_db()
        cursor = connection.cursor()

        try:
            cursor.execute('INSERT INTO Donations (donor_id, amount, donation_date, cause) VALUES (%s, %s, %s, %s)',
                           (post_data['donor_id'], post_data['amount'], post_data['donation_date'], post_data['cause']))
            connection.commit()
            response = {'message': 'Donation added successfully'}
            self._send_response(response, status_code=201)
        except mysql.connector.Error as e:
            self._send_response({'error': str(e)}, status_code=400)
        finally:
            connection.close()

    def handle_post_cause(self):
        content_length = int(self.headers['Content-Length'])
        post_data = json.loads(self.rfile.read(content_length))

        connection = self._connect_db()
        cursor = connection.cursor()

        try:
            cursor.execute('INSERT INTO Causes (name, description) VALUES (%s, %s)',
                           (post_data['name'], post_data['description']))
            connection.commit()
            response = {'message': 'Cause added successfully'}
            self._send_response(response, status_code=201)
        except mysql.connector.Error as e:
            self._send_response({'error': str(e)}, status_code=400)
        finally:
            connection.close()

    def _connect_db(self):
        return mysql.connector.connect(
            host='localhost',
            user='root',
            password='root',
            database='charity_donations'
        )

# Main execution
if __name__ == '__main__':
    PORT = 8000
    with socketserver.TCPServer(('', PORT), CharityDonationHandler) as httpd:
        print(f"Serving on port {PORT}")
        httpd.serve_forever()
