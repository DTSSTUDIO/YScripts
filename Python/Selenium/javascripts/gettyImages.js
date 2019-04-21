window.getCurrentPageImgUrls = () => {
    // Url dizisi
    const urls = [];

    // Url'leri tek tek alma
    const articleCollection = document.getElementById("assets").getElementsByTagName("article");
    for (let i = 0; i < articleCollection.length; i++) {
        const article = articleCollection[i];
        const url = article.getAttribute("data-thumb-url");

        // Url metin ise ekleme
        if (typeof url == 'string') {
            urls.push(url);
        }
    }

    return urls;
};

// Sonraki sayfaya geçme
window.nextPage = () => {
    document.getElementById("next-gallery-page").click();
};

return getCurrentPageImgUrls();
