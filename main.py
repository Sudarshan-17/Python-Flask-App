from flask import *
from flask_sqlalchemy import *
from datetime import datetime
import json
from flask_mail import Mail
from werkzeug.utils import *
import math

with open("config.json","r") as c:
    params = json.load(c)['params']

local_server = True
# print(params)

app = Flask(__name__)
app.secret_key='super-secret-key'
app.config['UPLOAD_FOLDER']= params['upload_location']
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail_password']

)

mail =Mail(app)

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)


class Contacts(db.Model):

    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80),  nullable=False)
    email = db.Column(db.String(20),  nullable=False)
    phone = db.Column(db.String(12),  nullable=False)
    msg = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)

class Posts(db.Model):
    s_no = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12),nullable=True)


@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no_of_posts']))
    #[0:params['no_of_posts']]
    #pagination logic
    page = request.args.get('page')
    # print(page)
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    # print(type(page))
    posts=posts[(page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    if page==1:
        prev = '#'
        # print(page)
        next = '/?page=' + str(page+1)
    elif page==last:
        next = '#'
        prev = '/?page=' + str(page - 1)
    else:
        prev = '/?page=' + str(page-1)
        next = '/?page=' + str(page+1)



    return render_template("index.html" , params=params,posts=posts,prev=prev,next=next)

@app.route('/about')
def about():
    return render_template("about.html", params=params)

@app.route('/contact' , methods=['GET','POST'])
def contact():
    if(request.method == 'POST'):
        '''Add entry to the database'''

        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        msg=request.form.get('msg')

        entry = Contacts(name=name, email=email, phone=phone, msg=msg, date= datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message from Blog' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body =msg + '\n' + phone
                          )


    return render_template("contact.html", params=params)


@app.route('/post/<string:post_slug>', methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html",params=params , post=post)

@app.route('/dashboard' ,methods=['GET','POST'])
def dashboard():
    if('user' in session and session['user'] == params['admin_user']):
        posts = Posts.query.all()
        return render_template('dashboard.html' ,params=params,posts=posts)

    if(request.method == 'POST'):
        username=request.form.get('username')
        userpass=request.form.get('pass')

        if(username == params['admin_user'] and userpass == params['admin_password']):
            #set the session variable
            session['user'] =username
            posts =Posts.query.all()
            return render_template('dashboard.html',params=params,posts=posts)
        else:
            return render_template("login.html", params=params)
    else:
        return render_template("login.html", params=params)

@app.route('/edit/<string:s_no>' ,methods=['GET','POST'])
def edit(s_no):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title =request.form.get('title')
            tagline = request.form.get('tagline')
            slug=request.form.get('slug')
            content=request.form.get('content')
            img_file=request.form.get('img_file')
            date = datetime.now()

            if(s_no=='0'):
                post=Posts(title = box_title, slug=slug,content=content,tagline=tagline,img_file=img_file ,date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post =Posts.query.filter_by(s_no=s_no).first()
                post.title=box_title
                post.slug=slug
                post.content=content
                post.tagline=tagline
                post.img_file=img_file
                post.date=date
                db.session.commit()
                return redirect('/edit/'+s_no)
        post=Posts.query.filter_by(s_no=s_no).first()
        return render_template('edit.html',params=params,post=post)

@app.route("/uploader", methods=['GET','POST'])
def uploader():
    if (request.method == 'POST'):
        f =request.files['file1']
        f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
        return "Uploaded Successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:s_no>")
def delete(s_no):
    if ('user' in session and session['user'] == params['admin_user']):
        post =Posts.query.filter_by(s_no=s_no).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')

if __name__ == '__main__':
    app.run(debug=True)