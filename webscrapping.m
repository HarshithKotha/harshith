/*for webscrapping the content*/
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
    /*for creating web page*/
    <!DOCTYPE html>
<html lang="en" style="background-image: url('../static/image/background.jpg');
background-attachment: fixed;">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cricket News</title>
    <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    
    <div class="mb-10 top-1 w-screen flex flex-col justify-center items-center">
        <img src="../static/image/logo.png" class="w-64 h-64" alt="Logo Image">
    </div>
    <div class="bottom-6 m-auto relative" id="container" style="width:614px; height:800px;">
        <img src="" id="bg" width="614px" height="800px"alt="image">
        <span class=" font-mono text-lg absolute text-white whitespace-pre-line text-justify" id="News"
            style="width: 550px; top: 200px; left: 30px; line-height: 2em;">
            {{News|safe}}
            <!-- These curly braces are a gateway for python variables and functions (via flask) to Front-end. This is done with the help of Jinja template engine.-->
        </span>
    </div>
    <div id="canvasWrapper" class="mb-10 w-screen flex justify-center items-center">
        <button type="button" class="text-black p-3 rounded-md font-sans text-xl bg-gradient-to-r from-green-400 to-blue-500 hover:from-pink-500 hover:to-yellow-500"
            onclick="download()">Screenshot me</button>
    </div>
    <script>
        var newbg = document.getElementById("bg");
        var background = new Image();
        background.src = "static/image/img" + (Math.floor(Math.random() * (5)) + 1) + ".jpg";
        newbg.src = background.src;
        console.log(newbg.src);
    </script>
    <script src="/static/h2c.min.js"></script>
    <script>
        function download() {
            html2canvas(document.getElementById("container"), { height: 800, width: 614 }).then(canvas => {
                //document.body.appendChild(canvas);
                var a = document.createElement('a');
                a.href = canvas.toDataURL("image/jpeg").replace("image/jpeg", "image/octet-stream");
                a.download = 'Screenshot.jpg';
                a.click();  
            });
        }
    </script>

</body>
</html>
