// TODO: Download işlemi bazı sitelerde çalışmamakta

// ! gatherVideosInfos metodu kullanılır

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

const WAIT_TIME = 1000

function getVideoName() {
    return $('.video-name')[0].innerText
}

function getVideoFilename() {
    return getVideoName() + ".mp4"
}

function getVideoUrl() {
    return $('video')[0].src
}

function getVideoSubtitlesUrls(srclang) {
    let urls = []

    subtitles = $('video track[kind=subtitles]')
    if (!srclang) {
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
    const video_filename = getVideoFilename()
    const video_url = getVideoUrl()
    const video_subtitles = getVideoSubtitlesUrls(srclang)

    return {
        "name": video_name,
        "filename": video_filename,
        "url": video_url,
        "subtitles": video_subtitles
    }
}

async function startCourse() {
    // url = https://www.coursera.org/learn/<kurs-ismi>/home/welcome
    $("a.link-button.primary.cozy")[0].click()
    await new Promise((r, j) => setTimeout(r, WAIT_TIME));
}


async function goNextVideo() {
    try {
        $('a.nav-link.dim.body-1-text')[1].click()
        await new Promise((r, j) => setTimeout(r, WAIT_TIME));
        return true
    } catch (e) {
        return false
    }
}

async function gatherVideosInfos() {
    infos = []

    // startCourse()

    do {
        try {
            info = getVideoInfo()
            infos.push(info)

            console.info(infos)
        } catch (e) {
            console.warn("Video bulunamadı")
        } finally {
            condition = await goNextVideo()
        }
    } while (condition)

    download(infos, "courses.json", "text/json")
}

download = (data, filename, mime) => {
    if (!data) {
        console.error("Veri olmadan indirme işlemi yapılmaz")
        return;
    }

    if (!data.includes("http")) {
        if (typeof data === "object") {
            mime = "text/json"
            data = JSON.stringify(data)
        }
        data = `data:${mime};charset=utf-8,${encodeURIComponent(data)}`

        if (!filename) {
            filename = `template.${(mime && mime.includes('/')) ? mime.split('/')[0] : "txt"}`
        }
    }

    if (!mime) mime = 'text/plain'
    if (!filename) filename = data.split('/').pop()

    const link = document.createElement("a");

    link.download = filename;
    link.href = data
    link.style.display = 'none';

    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    delete link;
}
