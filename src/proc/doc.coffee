fs = require 'fs'

module.exports = (spec) ->
  for i of spec.wiki.chapters
    for n of spec.wiki.chapters[i].pages
      file = 'src/doc/' + spec.wiki.chapters[i].pages[n].doc + '.md'
      if !fs.existsSync(file)
        return false
      page = spec.wiki.chapters[i].pages[n].doc.split('/')
      page = page[page.length-1]
      spec.wiki.chapters[i].pages[n].content = fs.readFileSync(file, 'utf8')
      spec.wiki.chapters[i].pages[n].page = page
      spec.wiki.chapters[i].pages[n].title = spec.wiki.chapters[i].pages[n].content.split("\n")[0].replace(/^# */, '').replace(/<img(.*?)> ?/, '')
  
  spec