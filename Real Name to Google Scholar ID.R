#Scraping google scholar user IDs
#Search URL looks like: https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=Olga+Chyzh+Iowa+state+university&btnG=

#Useful code ***Ike don't delete***
#URL of author search
search.url = "https://scholar.google.com/citations?hl=en&view_op=search_authors&mauthors=David+Andersen+Iowa+state+university&btnG="
#turning webpage into data
webpage = read_html(search.url)
#reading all link nodes
readnodes = html_nodes(webpage,'a')
#subsetting to only link node 19 which contains username
profile.url = readnodes[19]
#string manipulations to give only username
profile.url = substr(profile.url,11,100)
profile.url = word(sub(pattern = ";", replacement = " ", x = profile.url),1)
profile.url = sub(pattern = "=", replacement = " ", x = profile.url)
profile.url = sub(pattern = "&", replacement = " ", x = profile.url)
profile.url = word(profile.url,2)
profile.url

