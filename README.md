#Google rank search
Scripts to launch a search and find what position the page has

Example of use:
```
./get_position.pl --api_key **** --web_page www.example.com --query_string "term+search" --search_engine *******
```

You have to create a search engine. More info: https://developers.google.com/custom-search/json-api/v1/introduction

## Installation
To install do a clone:
```
```
Install all the required libraries with carton:
```
cd google-search-position
carton install
```
To run:
```
carton exec bash -l
./get_position.pl --api_key **** --web_page www.example.com --query_string "term+search" --search_engine *******
```
