---
layout: ../../layouts/MarkdownPostLayout.astro
title: 'Survvit: my weekend project'
publishedAt: 2011-05-19
source: crossbrowser
---

<p style="text-align: center;"><img src="/assets/survvit/rails.png" alt="Rails logo" /></p>
<p>A couple of weekends ago, I decided to build a simple app using <a title="Ruby on Rails" href="https://rubyonrails.org/">Ruby on Rails</a>, just to learn more about the framework. For the project, I decided to build a simple survey application that people could use to send custom surveys to people they know. The twist here is that you don't choose a single option as your answer, but you upvote and downvote options just as <a title="reddit" href="https://www.reddit.com/">Reddit</a> does with the submitted links, hence the Reddit inspired name, <a title="Survvit" href="http://www.survvit.com">Survvit</a>. This enables less popular option to sink and only the most popular or less controversial option to win. The inspiration came from work where we were trying to come up with names for our new servers.</p>
<h3>Things I learned</h3>
<h4>Token generation</h4>
<p>I wanted people to be able to generate semi-private surveys without bothering with registration and authentication. So the surveys are semi-private because anyone with the URL can access the survey and answer it, but the URLs are not guessable because I developed a token generator that generates a random string of characters. This is in no way something new, but I'm glad I learned how to implement it.<!--more--></p>
<h4>Stupid authentication</h4>
<p>A big annoyance of mine when it comes to creating a new project is that I don't want to deal with authentication. I'd rather build a whole project and then plug in some authentication mechanism once the rest of the application is solid. However, a lot of my projects require user accounts to be useful. With this project, I only needed admin access for myself in order to do some cleanup from time to time. So for this implementation, the username and password are hardcoded in the application itself (the password is hashed just to be sure).</p>
<h4>Front-end development with Ruby on Rails and MVC</h4>
<p>I learned a lot about front-end development with Ruby on Rails, it's not always intuitive but overall it's a pretty straightforward process. I learned how to make use of partials and yields to keep true to the DRY principle as much as possible. I was also new to the whole MVC thing, I didn't have to chance to try it at work with ASP.NET, and was pleasantly surprised with the simplicity and how much easier it is to use (in comparison with ASP.NET WebForms).</p>
<h4>Heroku</h4>
<p><a title="Heroku" href="https://www.heroku.com/">Heroku</a> is great for hosting small projects (probably good for bigger project too, I just didn't try it). It's free if you need a single worker thread and a small database (my case) and is extremely easy to set-up. I definitely recommend this if you want to try your hand at small Ruby on Rails projects.</p>
<h4>IDE</h4>
<p>For this project, I used <a title="Aptana Studio 3" href="http://aptana.com/products/studio3">Aptana Studio 3</a>, it's a decent IDE, but it's definitely not as crisp and responsive as I would like. Coming from a .Net development environment, I'm used to working with IDEs, but I haven't found a solid one for Windows yet. There were a couple that looked promising, but I didn't want to spend money as I don't develop with Ruby on Rails very often. I'm thinking Notepad++ with a decent shell would be a decent alternative.</p>
<h3>Wrap-up</h3>
<p>Overall, I'm quite satisfied with how the project turned out, I had very little prior experience with Ruby on Rails, yet I managed to code a working, though incomplete, application in a dozen of hours. The biggest drawback for Ruby on Rails for me at the moment is the lack of a decent IDE on Windows and my lack of experience. Hopefully, as I get better with Rails, I'll find a comfortable working environment and I'll be able to churn out code without having to constantly look for documentation.</p>
<p>PS: Heroku seems to be having issue with my application, this is unfortunate as everything was working perfectly until a couple of weeks ago.</p>
