---
layout: ../../layouts/MarkdownPostLayout.astro
title: 'Crowdsourced brute-forcing: how Fez was a coop game for a couple of hours'
publishedAt: 2012-04-19
source: crossbrowser
---
<p>On April 13, 2012 the long awaited indie game <a title="Official Fez website" href="http://polytroncorporation.com/fez">Fez</a> was finally released after 5 years of troublesome development. The goal of the game is to explore the environment, solve puzzles and collect cubes in order to unlock doors. The game is a 2d side-scroller living in a 3d environment. It is better viewed then explained:</p>

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/40269839?h=b79006aa2c" style="position:absolute;top:0;left:0;width:100%;height:100%;" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>
<p style="text-align: center; font-style: italic;"><a href="https://vimeo.com/40269839">FEZ LAUNCH TRAILER</a> from <a href="https://vimeo.com/polytroncorporation">POLYTRON</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

<p>The main goal is to collect the 32 golden cubes, but the more perseverant gamers can also try to collect 32 anti-cubes and more by solving much more difficult puzzles. The gaming community collaborated on the more difficult ones, but the last one had yet to be solved a few days after all the others had been solved.</p>

<h3>The last puzzle</h3>
<p>If you are already familiar with the story surrounding the last puzzle, jump to the next section.</p>
<p>The main theory for the last puzzle was that players had to stand at a very specific spot in the game and input a sequence of button presses. The standard sequences in the game are 8 inputs long and use up to 7 different buttons. Needless to say, no one wanted to try <strong>2 097 152</strong> different combinations, hence why players tried to make sense of some of the remaining mysteries in the game.</p>
<p>After a few days of unsuccessful attempts at breaking the code, the community realized that joining hands and brute-forcing the sequences together was a viable alternative. Fortunately, a player who had found the solution started dropping hints to dramatically reduce the set of possible solutions to a more manageable 78 125 combinations (he said the sequence was 7-inputs long and only used 5 inputs). Some people created a shared spreadsheet on Google Docs to split the work of trying the thousands of sequences, I went a different way.</p>
<p>Ars Technica wrote a good <a title="Practically impossible: The quest to decipher Fez's cryptic final puzzle" href="http://arstechnica.com/gaming/news/2012/04/why-it-took-almost-a-week-for-the-world-to-completely-finish-fez.ars">article about the story around the puzzle</a>.</p>

<h3>Rails, Heroku and Bootstrap: a success story</h3>
<p>I was not too fond of the spreadsheet, not because it was a bad idea, but it just seemed a crude way of splitting the work even though it was practical and easy to set-up. On Tuesday evening (the 17th) I decided I would build a web application that would present visitors 10 sequences to try, then they could say whether one of the sequences worked or not. The user would then be presented 10 more sequences to try and so on until the solution was found.</p>
<p>To generate the sequences in an optimal order I used a <a title="Wikipedia entry on the De Bruijn sequence" href="http://en.wikipedia.org/wiki/De_Bruijn_sequence#Algorithm">De Bruijn sequence algorithm</a> (thanks to <a title="Question on codegolf.stackexchange.com leading me to the De Bruijn sequence" href="http://codegolf.stackexchange.com/questions/5552/generate-a-list-of-all-possible-input-combinations-in-an-optimal-order-for-entry">Peter Taylor for telling me about it</a>).</p>
<blockquote>A <strong>De Bruijn sequence</strong> [...] is a cyclic sequence of a given alphabet <em>A</em> with size <em>k</em> for which every possible subsequence of length <em>n</em> in <em>A</em> appears as a sequence of consecutive characters exactly once.</blockquote>

<p>This was perfect for the problem at hand since the sequences could be entered in any order, only the last 7 button presses were checked to see if the sequence was right.</p>

<p style="text-align: center;">
  <img src="/assets/fez/fez-bruijn-arrows.png">
  <br>
  <em>In the image above, entering the first row in order then entering the last input of each subsequent rows will input all 4 sequences in 8 inputs instead of 20. For 10 sequences of 7 characters, that's 16 inputs instead of 70.</em>
</p>

<p>No more than a couple hours were needed to build a rudimentary version of the app. I unit tested the basic algorithms to make sure they behaved correctly and launched the app on heroku only a few hours after I had started working on it. I then shared the link (<del class="no-ws">fez-monolith.heroku.com</del> <a title="The crowdsourced brute-forcing app" href="http://fez.mbillard.com/">fez.mbillard.com</a>) on a <a title="Gamefaqs thread for players working on the last puzzle" href="http://www.gamefaqs.com/boards/961239-fez/62566926">Gamefaqs thread</a> where some players had gathered to work on the puzzle.</p>
<h3>Trolls, false positives and false negatives</h3>
<p>As soon as the app went live I was already working on the next version where people could confirm or deny sequences marked as being right. This turned out to be very important because trolls were already trying to negate the work of others by entering false information like marking untested sequences as invalid or marking invalid sequences as being the solution.</p>
<p>The fix for false positives was quite easy, people could just confirm or deny them, they would then disappear from the list of potential solutions. However, false negatives were harder to detect, the only way was to have more than one person try each sequence. Unfortunately for the community, the correct sequence was marked as invalid relatively early in the life of the app.</p>
<h3>Causes of false negatives and why mysql != postgresql</h3>
<p>Each false negative was the result of one of these 3 problems:</p>
<ul>
<li>trolls purposefully marking any sequence as being invalid</li>
<li>users not inputting the sequences correctly</li>
<li>my lack of experience with postgresql</li>
</ul>
<p>To understand, take a look at the following code used to retrieve 10 supposedly consecutive sequences (which had been created in order in the database):</p>
<code class="code-block">
# Get a random set of X consecutive sequences<br />
@sequences = Sequence.where("id &gt;= ?", random_sequence_id).limit(nb_sequences)<br />
</code>
<p>
What's wrong? There's no ordering in the retrieval of the sequences. On my development machine this wasn't a problem because I was using MySQL which was returning the sequences in the expected order. Postgresql on the other hand, which was required on Heroku, did not always return the sequences in order. This probably caused some users to input the sequences using the suggested method (the first sequence fully then only the last input of each following sequence). Someone reported the issue, but unfortunately I could only fix it much later in the day after my normal workday. This was entirely my fault for not knowing that a SQL query is non-deterministic without an <code class="inline">order by</code> clause.</p>

<h3>Some stats and conclusion</h3>
<p>Time between when the app went live to when the solution was found: ~18h</p>
<p>Number of contributors: more than 1300</p>
<p>Number of trolls: 123 people found a correct sequence, 20 of them found a lot more than one</p>
<p>Number of tested sequences: 66,227/78,125 (84.771%)</p>
<p>Number of false positives: 515</p>

<p>The solution had been marked as negative about 5 hours after the app went live either by someone trying to ruin the efforts of the others, because of an error from the player inputting the sequence or due to the ordering error in my code mentioned earlier.</p>
<p>Overall I am very satisfied with the project, it was shared by many on Twitter and on various forums as well as on <a title="Kotaku article about the last puzzle and the community trying to find the solution" href="http://kotaku.com/5903095/ridiculously-obscure-black-monolith-in-fez-rallies-gamers-to-a-group-effort">Kotaku</a>. I managed to set-up a very useful application in a matter of hours using Rails, Heroku and Bootstrap. The <a title="Crowdsourced brute-forcing for the last puzzle in Fez" href="http://fez.mbillard.com/">current website</a> will remain live as I see no reason to take it down, I have put it in a frozen state to preserve its state at the time the sequence was found.</p>
<p>The <a title="GitHub page for the web application" href="https://github.com/mbillard/fez_monolith">code for the app is available on GitHub</a>.</p>
<p style="text-align:center;"><img src="/assets/fez/Fez_heart_room-300x262.png" alt="Picture of Gomez in the room with the completed heart" width="300" height="262" /></p>
