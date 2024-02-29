import requests
from bs4 import BeautifulSoup
import pandas as pd
from pathlib import Path
import csv 
import os
import json

path = os.getcwd()
csp = str(Path(path))
path_export = rf'{csp}/datasets/'
Path(path_export).mkdir(parents=True, exist_ok=True)

#initiate jsosn file
with open('data.json', 'r') as file:
    data = json.load(file)

# defines how many levels are to be scrapped
levels = 5

print(path_export)

# function that scrapes the data from each level and pages
def getSoup(level, page):
    try: #try to get response from website
        url = f'https://www.fortiguard.com/encyclopedia?type=ips&risk={level}&page={page}'
        response = requests.get(url)
        return BeautifulSoup(response.text, 'html.parser') #return soup object
    except:
        #this will run if only had error when accessing the website, then records into json at what level and page the website cannot be accessed.
        message = f'cant acces page {page} on level {level}'
        print(f"x{page}x")
        with open(path_export+f'skipped.json', 'w') as f:
            json.dump({"error": str(message)}, f)

def getMaxPage(soup):
    # Extract <a> tags from each <a class="page-link"> tag
    pages = soup.find_all('a', class_='page-link')
    # get only number value of tag a
    pagesDigitsOnly = [value.text for value in pages if value is not None and value.text.isdigit()]
    # define last page as maximum pages
    if not pagesDigitsOnly:
        return 0
    else:
        return int(pagesDigitsOnly[-1]) #returning integer value of max pages
    
for level in range(levels):
    #define list for export as csv after complete
    export = []
    export.append(["Title", "Link"])     #define column name of csv file
    
    print(f'\nlevel: {level+1}', end=" page: ")
    
    soup = getSoup(level+1,1)
    maxPage = getMaxPage(soup)

    if maxPage != 0:
        for page in range(maxPage):
            soup = getSoup(level+1,page+1)

            # Find section with class="table-body"
            tables = soup.find('section', class_='table-body')
            # get all div element who has class="row"
            try:
                row_divs = tables.find_all('div', class_='row')
            except:
                message = f'No data on level {level+1} page {page+1}'
                print(f"x{page+1}x")
                with open(path_export+f'skipped.json', 'w') as f:
                    json.dump({"error": str(message)}, f)
                    continue
            for div in row_divs:
                bTag = div.find('b') #find B html tag because we know value of title is in B tag
                if bTag:
                    title = bTag.text #get text between B tag start and B tag end
                urlTag = div.get('onclick') #get onclick attribute which contain link
                if urlTag:
                    urlTag = "https://www.fortiguard.com/"+'/'.join(urlTag.replace("'", "").split('/')[1:])
                export.append([title, urlTag]) #apend title and url into export list
            print(page+1, end=' ')

        #writing list into .csv file
        with open(path_export+f'forti_lists_{level+1}' + '.csv', 'w', encoding='UTF8', newline='') as nf:
            wr = csv.writer(nf)
            wr.writerows(export)
            print('>> Succcesfully exported')
    
