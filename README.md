MailCount (MC)
=========

MailCount is an [ubersicht](https://github.com/felixhageloh/uebersicht) plugin to display the number of unread emails in your gmail account.

Installation
============
1. Download and move mc.widget to your ubersicht widgets folder.
2. Replace `<user>` on line 1 with your gmail account username.[^1]
3. Optionally, adjust the color thresholds to your liking.

Screenshots
===========
![network_view](assets/network_view.png)
It also gracefully fails when you lose network connectivity, by continuing to display your inbox count, but noting the last update time:[^2]
![disconnected_view](assets/disconnected_view.png)

---
[^1]: note that this requires you are using OSX and your gmail account credentials be stored in your OSX keychain.

[^2]: if you refresh the widget however, you'll just see a `↭` symbol indicating lack of connectivity.
