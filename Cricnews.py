//For webscrapping content
from flask import Flask,render_template
from bs4 import BeautifulSoup
import requests

app = Flask(__name__)
@app.route('/',methods=["GET","POST"])
def index():
    url="https://www.cricbuzz.com/cricket-news"
    req = requests.get(url)
    soup = BeautifulSoup(req.content,"html.parser")
    dataout=soup.find_all("div",class_="cb-col cb-col-100 cb-lst-itm cb-pos-rel cb-lst-itm-lg",limit = 7)
    finalnews=""
    for data in dataout:
        news=data.div.a["title"]
        finalnews+= "\u27A2" + "  " + news + "\n"
    return render_template("index.html",News=finalnews)
