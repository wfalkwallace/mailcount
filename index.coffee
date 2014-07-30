username = "<user>"     # enter your gmail account username here
password = "<pass>"     # enter your gmail account password here


command: "curl -su #{username}:#{password} https://mail.google.com/mail/feed/atom || echo \"null\""

refreshFrequency: 10000     # refresh every 10 seconds (10k ms)

render: (_) -> """
  <div class='count'>~</div>
  <div class='ts hidden'></div>
"""

update: (output, domEl) ->
  fullcount_regex = /.*<fullcount>(\d+)<\/fullcount>.*/
  fullcount_match = output.match(fullcount_regex)
  if fullcount_match
    fullcount = fullcount_match[1]
    $(domEl).find('.count').text fullcount
    $(domEl).find('.ts').addClass('hidden')
    $(domEl).find('.ts').text('as of ' + @ftime())

    if fullcount < 10
      $(domEl).find('.count').css color: '#c6fbc8'
    else if fullcount >= 10 and fullcount < 15
      $(domEl).find('.count').css color: ':#fff'
    else
      $(domEl).find('.count').css color: ':#ff4d4d'
  else
    $(domEl).find('.ts').removeClass('hidden')



style: """
  bottom:5%
  left:5%
  color:#fff
  font-family:Helvetica Neue
  text-align:center

  .count
    font-size:7em

  .ts
    font-size:1em

  .hidden
    display:none
"""

ftime: () ->
  localtime = new Date()
  timestamp = (localtime.getHours() % 12 || 12) + ':' + localtime.getMinutes()