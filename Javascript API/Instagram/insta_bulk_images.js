/**
 * Resimlerin url'lerini consola basar
 */

const DELAY = 1000
const FILENAME = "dump.url"

async function gather(test = false) {
    const urls = await gatherUrls(test)
    filetext = urls.join("\n")
    download(FILENAME, filetext)
}

async function gatherUrls(test = false) {
    const imgs = gatherImages()
    const urls = []
    for (let i = 0; i < (typeof test == 'number' ? test : imgs.length); i++) {
        img = imgs[i]

        // Benzersiz ise url dizisine ekleme
        url = await getOriginImgUrl(img)
        if (!urls.includes(url)) {
            urls.push(url)
        }
    }
    return urls
}

function gatherImages() {
    return document.getElementsByClassName("FFVAD")
}

async function getOriginImgUrl(img) {
    img.click()

    const url = await startDelayed(getImageUrl, DELAY)
    closePopUp()

    return url
}

async function startDelayed(method, ms) {
    await new Promise((r, j) => setTimeout(r, ms));
    return method();
}

function getImageUrl() {
    const imgs = document.getElementsByClassName("FFVAD")
    return imgs[imgs.length - 1].src
}

function closePopUp() {
    document.querySelector("button.ckWGn").click()
}

function printArray(array) {
    if (typeof (array) != 'undefined') {
        for (let i = 0; i < array.length; i++) {
            console.log(array[i])
        }
    }
}

function download(filename, text, mime = 'text/plain') {
    const link = document.createElement("a");

    if (mime.includes("json")) {
        text = JSON.stringify(text)
    }

    link.download = filename;
    link.href = `data:${mime};charset=utf-8,${encodeURIComponent(text)}`;
    link.style.display = 'none';

    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

    delete link;
}
