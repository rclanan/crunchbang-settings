#! /usr/bin/python
# -*- coding: utf-8 -*-

import feedparser

url = "http://ws.audioscrobbler.com/1.0/user/rclanan/recenttracks.rss"
feed = feedparser.parse(url)
title = feed[ "items" ][0][ "title" ]
title=title.replace(u"–","-")
#album_link = feed[ "items" ][0][ "link" ].encode("ascii", "ignore")
number_of_letters = len(title)

if number_of_letters > 63:
	print title[0:62]
else:
	print title
