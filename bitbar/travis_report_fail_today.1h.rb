#!/usr/bin/env ruby

require 'travis_report'

THREADS = 10

c = %(tiimgreen/github-cheat-sheet
enaqx/awesome-react
ziadoz/awesome-php
vsouza/awesome-ios
matteocrippa/awesome-swift
cjwirth/awesome-ios-ui
herrbischoff/awesome-osx-command-line
alebcay/awesome-shell
wsargent/docker-cheat-sheet
hangtwenty/dive-into-machine-learning
neutraltone/awesome-stock-resources
hsavit1/Awesome-Swift-Education
iCHAIT/awesome-osx
rosarior/awesome-django
n1trux/awesome-sysadmin
veggiemonk/awesome-docker
pcqpcq/open-source-android-apps
ellisonleao/magictools
willianjusten/awesome-svg
dhamaniasad/awesome-postgres
humiaozuzu/awesome-flask
JStumpp/awesome-android
dariubs/GoBooks
unixorn/awesome-zsh-plugins
pazguille/offline-first
chentsulin/awesome-graphql
arslanbilal/git-cheat-sheet
dahlia/awesome-sqlalchemy
webpro/awesome-dotfiles
ashishb/android-security-awesome
rshipp/awesome-malware-analysis
mfornos/awesome-microservices
lerrua/remote-jobs-brazil
sitepoint/awesome-symfony
isRuslan/awesome-elm
watson/awesome-computer-history
wbinnssmith/awesome-promises
dotfiles/dotfiles.github.com
diegocard/awesome-html5
stefanbuck/awesome-browser-extensions-for-github
fasouto/awesome-dataviz
uraimo/Awesome-Swift-Playgrounds
sotayamashita/awesome-css
RichardLitt/awesome-conferences
FriendsOfCake/awesome-cakephp
caesar0301/awesome-pcaptools
matiassingers/awesome-readme
matteofigus/awesome-speaking
AchoArnold/discount-for-student-dev
afonsopacifer/awesome-flexbox
KotlinBy/awesome-kotlin
burningtree/awesome-json
vredniy/awesome-newsletters
vredniy/awesome-newsletters
uralbash/awesome-pyramid
ahkscript/awesome-AutoHotkey
aleksandar-todorovic/awesome-c
HQarroum/awesome-iot
phillipadsmith/awesome-github
sergeyklay/awesome-phalcon
ipfs/awesome-ipfs
iJackUA/awesome-vagrant
ramitsurana/awesome-kubernetes
bucaran/awesome-fish
yenchenlin1994/awesome-watchos
MakinGiants/awesome-mobile-dev
MakinGiants/awesome-mobile-dev
lnishan/awesome-competitive-programming
notthetup/awesome-webaudio
deanhume/typography
filipelinhares/awesome-slack
brunopulis/awesome-a11y
vinkla/awesome-fuse
brabadu/awesome-fonts
benoitjadinon/awesome-xamarin
mark-rushakoff/awesome-influxdb
christian-bromann/awesome-selenium
unixorn/git-extra-commands
RichardLitt/endangered-languages
Neueda4j/awesome-neo4j
vkarampinis/awesome-icons
rabbiabram/awesome-fortran
tedyoung/awesome-java8
yangshun/awesome-spinners
joubertredrat/awesome-devops
wfhio/awesome-job-boards
ipfs/newsletter
jjaderg/awesome-postcss
stve/awesome-dropwizard
ramitsurana/awesome-openstack
jakoch/awesome-composer
cdleon/awesome-front-end
)

r = c.split("\n").map { |l| l.sub '', ''}
results = []
TravisReport::collect r, THREADS, true, true do |r, t|
  results.push t
end

attributes = ' | size=8'
if results.count == 0
  o = '👷\n✅'
  o << attributes
  puts o
else
  o = '👷\n🔴'
  o << attributes
  puts o
  puts '---'
  results.each do |t|
    slug = t.slug

    build = t.last_build

    j = build.jobs[0]
    jid = j.build_id

    puts "#{slug} | href=https://travis-ci.org/#{slug}/builds/#{jid}"
  end
end
