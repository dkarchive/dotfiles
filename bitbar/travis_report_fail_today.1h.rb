#!/usr/bin/env ruby

require 'travis_report'

THREADS = 10

c =%(tiimgreen/github-cheat-sheet
vinta/awesome-python
enaqx/awesome-react
ziadoz/awesome-php
caesar0301/awesome-public-datasets
vsouza/awesome-ios
cjwirth/awesome-ios-ui
matteocrippa/awesome-swift
alebcay/awesome-shell
akullpp/awesome-java
neutraltone/awesome-stock-resources
hangtwenty/dive-into-machine-learning
hsavit1/Awesome-Swift-Education
iCHAIT/awesome-osx
rosarior/awesome-django
n1trux/awesome-sysadmin
pcqpcq/open-source-android-apps
ellisonleao/magictools
veggiemonk/awesome-docker
humiaozuzu/awesome-flask
JStumpp/awesome-android
dariubs/GoBooks
unixorn/awesome-zsh-plugins
arslanbilal/git-cheat-sheet
rshipp/awesome-malware-analysis
chentsulin/awesome-graphql
webpro/awesome-dotfiles
lerrua/remote-jobs-brazil
sitepoint/awesome-symfony
dotfiles/dotfiles.github.com
wbinnssmith/awesome-promises
mfornos/awesome-microservices
diegocard/awesome-html5
fasouto/awesome-dataviz
RichardLitt/awesome-conferences
FriendsOfCake/awesome-cakephp
matteofigus/awesome-speaking
isRuslan/awesome-elm
caesar0301/awesome-pcaptools
sotayamashita/awesome-css
burningtree/awesome-json
matiassingers/awesome-readme
najela/discount-for-student-dev
vredniy/awesome-newsletters
stefanbuck/awesome-browser-extensions-for-github
uralbash/awesome-pyramid
afonsopacifer/awesome-flexbox
ahkscript/awesome-AutoHotkey
HQarroum/awesome-iot
aleksandar-todorovic/awesome-c
phillipadsmith/awesome-github
iJackUA/awesome-vagrant
notthetup/awesome-webaudio
filipelinhares/awesome-slack
MakinGiants/awesome-mobile-dev
ipfs/awesome-ipfs
deanhume/typography
brunopulis/awesome-a11y
uraimo/Awesome-Swift-Playgrounds
christian-bromann/awesome-selenium
unixorn/git-extra-commands
vinkla/awesome-fuse
mark-rushakoff/awesome-influxdb
vkarampinis/awesome-icons
benoitjadinon/awesome-xamarin
ramitsurana/awesome-kubernetes
rabbiabram/awesome-fortran
yangshun/awesome-spinners
tedyoung/awesome-java8
wfhio/awesome-job-boards
joubertredrat/awesome-devops
ipfs/weekly
ramitsurana/awesome-openstack
Neueda4j/awesome-neo4j
watson/awesome-computer-history
lnishan/awesome-competitive-programming
yenchenlin1994/awesome-watchos
dhamaniasad/awesome-postgres
)

r = c.split("\n").map { |l| l.sub '', ''}
results = []
TravisReport::collect r, THREADS, true, true do |r, t|
  results.push t
end

if results.count == 0
  puts '✅'
else
  puts '🔴'
  puts '---'
  results.each do |t|

    slug = t.slug

    build = t.last_build

    j = build.jobs[0]
    jid = j.build_id

    puts "#{slug} | href=https://travis-ci.org/#{slug}/builds/#{jid}"
  end
end
