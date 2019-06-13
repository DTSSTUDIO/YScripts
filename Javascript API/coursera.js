function loadJQuery() {
    async function loadScript(url) {
        let response = await fetch(url);
        let script = await response.text();

        console.log("JQuery eklendi")
        eval(script);
    }

    let scriptUrl = 'https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js'
    loadScript(scriptUrl);
}
loadJQuery()

function getVideoName() {
    return $('.video-name')[0].innerText
}

function getVideoUrls() {
    return $('video')[0].src
}

function getVideoSubtitlesUrls(srclang) {
    let urls = []

    subtitles = $('video track[kind=subtitles]')
    if (typeof (srclang) == "undefined") {
        subtitles.each(index => {
            urls.push(subtitles[index].src)
        })
    } else {
        subtitles.each(index => {
            if (subtitles[index].srclang == srclang) {
                urls.push(subtitles[index].src)
            }
        })
    }

    return urls
}

function getVideoInfo(srclang) {
    const video_name = getVideoName()
    const video_url = getVideoUrls()
    const video_subtitles = getVideoSubtitlesUrls(srclang)

    return {
        "name": video_name,
        "url": video_url,
        "subtitles": video_subtitles
    }
}
