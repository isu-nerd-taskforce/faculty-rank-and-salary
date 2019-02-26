#Google Scholar Webscraper
#html auto
library('xml2')
library('rvest')
url = 'https://scholar.google.com/citations?user=u2-9j0YAAAAJ&hl=en&oi=ao'
ur2 = 'https://scholar.google.com/citations?hl=en&user=u2-9j0YAAAAJ&view_op=list_works&sortby=pubdate'
ur1 = download.file('https://scholar.google.com/citations?user=u2-9j0YAAAAJ&hl=en&oi=ao','C:\Users\Ike\Desktop\school\College\Political Science\PolS457\ur1.html')
webpage = read_html(url)
Citation_data_html = html_nodes(webpage,'.gs_gray')
Citation_data = html_text(Citation_data_html)
grepl(("Hystrix"|"apple"),Citation_data, fixed=TRUE)

gscholar_lines = readLines('https://scholar.google.com/citations?user=u2-9j0YAAAAJ&hl=en&oi=ao')

top_journals = c("Trends in Ecology & Evolution", "Molecular Biology and Evolution", "Systematic Biology", "Evolution", "Molecular Phylogenetics and Evolution", "Ecology and Evolution", "Genome Biology and Evolution", "Evolutionary Applications", "BMC Evolutionary Biology", "Heredity")
top_journals = "Trends in Ecology & Evolution | Molecular Biology and Evolution | Systematic Biology | Evolution | Molecular Phylogenetics and Evolution | Ecology and Evolution | Genome Biology and Evolution | Evolutionary Applications | BMC Evolutionary Biology | Heredity"



grep(top_journals,gscholar_lines)
gscholar_lines[57]


url = 'https://scholar.google.com/citations?user=u2-9j0YAAAAJ&hl=en&oi=ao'
webpage = read_html(url)
readnodes = html_nodes(webpage,'.gsc_a_t')
nodetext = html_text(readnodes)
nodetext
grep(top_journals,nodetext)

