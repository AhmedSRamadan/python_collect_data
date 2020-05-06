from flask import Flask
from twilio.rest import Client
import requests


app = Flask(__name__)

html_response = """<html>
		<body>
		<h1>
			 The interesting chuck nories jokes are : 	
		</h1>

		<ul>
		         {}
		</ul>

		</body>
		</html>"""


@app.route('/')
def hello_world():
	response = requests.get('https://api.chucknorris.io/jokes/search?query=interesting')
	jokes = response.json()

	allvalues = ""
	for jokevalue in jokes['result']:
		allvalues += '<li>{}</li>'.format(jokevalue['value'])

	return html_response.format(allvalues)

