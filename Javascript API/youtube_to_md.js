var names = document.querySelectorAll("span.style-scope.ytd-playlist-video-renderer")
var links = document.getElementsByClassName("yt-simple-endpoint style-scope ytd-playlist-video-renderer")

var markdown = ""
for (let i = 0; i < names.length; i++) {
    markdown += `- [${names[i].innerText}](${links[i].href})\n`
}
console.log(markdown)
