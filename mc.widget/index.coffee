username = "<user>"     # enter your gmail account username here

command: "security find-internet-password -ga #{username} 2>&1 | grep \"password\" | sed -e 's/^[^\"]*\"//' -e 's/\".*$//' | xargs -I pass curl -su #{username}:pass https://mail.google.com/mail/feed/atom || echo \"null\""

refreshFrequency: 10000     # refresh every 10 seconds (10k ms)

render: (_) -> """
  <div class='count'>↭</div>
  <div class='ts hidden'></div>
"""

update: (output, domEl) ->
  # feel free to modify these  to fit your workflow/inbox
  lowcount_color = '#c6fbc8'
  lowcount_max = 9
  midcount_color = '#fff'
  midcount_max = 14
  highcount_color = '#ff4d4d'

  fullcount_regex = /.*<fullcount>(\d+)<\/fullcount>.*/
  fullcount_match = output.match(fullcount_regex)
  if fullcount_match
    fullcount = fullcount_match[1]
    $(domEl).find('.count').text fullcount
    $(domEl).find('.ts').addClass('hidden')
    $(domEl).find('.ts').text('as of ' + @ftime())

    if fullcount <= lowcount_max
      $(domEl).find('.count').css color: lowcount_color
    else if fullcount > lowcount_max and fullcount <= midcount_max
      $(domEl).find('.count').css color: midcount_color
    else
      $(domEl).find('.count').css color: highcount_color
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
  timestamp = (localtime.getHours() % 12 || 12) + ':' + (localtime.getMinutes() < 10 && 0 + localtime.getMinutes() || localtime.getMinutes()) + ' ' + (localtime.getHours() < 12 && 'AM' || 'PM')
