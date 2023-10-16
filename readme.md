# Analyze flight delays in ruby

* data and assignment idea from [https://byuistats.github.io/CSE250-Course/projects/project-2/](https://byuistats.github.io/CSE250-Course/projects/project-2/)

# Generate data in a json or csv format, then analyze it

## Part 1
- pick a format for interesting data that you might care about
- build Ruby analysis of some basic features of that data (min, max, mean, percentages)
- graph something with excel
## Part 2
- using the data format (csv or json), have ChatGPT generate data that fits the given format
    - but have some interesting nuance, such as we saw for TV Shows
- analyze the data you generated for using your code from part 1
    - how good of a job did ChatGPT do?
- now refine your prompt(s) for generating data and try to generate better data

### Thoughts for data format
- Don't use TV Shows or flight delays, as we have already done both of those
- You can make up your own data format, or ask ChatGPT to help you
- You should have some _interesting_ fields for analysis, such as:
    - numerical data (check min/max/mean/stdev, etc)
    - dates (clustered, distributed, etc)
- This will be more fun if you pick something you care about and find interesting

### Data format ideas
- [https://cricsheet.org/format/json/#introduction-to-the-json-format](JSON Cricket Data from cricsheet)
- [http://theliquidfire.com/2018/02/19/make-a-ccg-json/](JSON data for a deck building card game)
- TODO: other data sources
