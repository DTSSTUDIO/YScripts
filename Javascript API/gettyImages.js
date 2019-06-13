/**
 * Resim urllerini alma
 * @param {number} pageNum Sayfa sayısı
 */
function getImageUrls(pageNum) {
  pageNum = pageNum === 0 ? 67 : pageNum;
  const urls = [];
  // Her saufa için tekrarlama.
  // Not: Sayfa sayısı 1'den başlar
  for (let i = 1; i < pageNum; i++) {
    const articleCollection = document.getElementById("assets").getElementsByTagName("article");
    const articles = [...articleCollection];
    articles.forEach(article => {
      const url = article.getAttribute("data-thumb-url");
      urls.push(url);
    });

    // Sonraki sayfaya geçme
    document.getElementById("next-gallery-page").click();
  }
  // urls.length;
  return urls;
}

// https://www.gettyimages.com/photos/traffic-light?alloweduse=availableforalluses&family=creative&license=rf&page=2&phrase=traffic%20light&sort=best
// page'lere gir tek tek indir
function insertImageUrls(urls = [], loop = 1, delay = 3000) {
  if (loop > 0) {
    const articleCollection = document.getElementById("assets").getElementsByTagName("article");
    for (let j = 0; j < articleCollection.length; j++) {
      const url = articleCollection[j].getAttribute("data-thumb-url");
      urls.push();
    }

    // Sonraki sayfaya geçme
    nextPage();

    // Gecikmeli tekrar etme
    // window.setInterval(() => {
    //     insertImageUrls(urls, loop - 1);
    // }, delay);
  }
}

function nextPage() {
  document.getElementById("next-gallery-page").click();
}

function logArr(arr) {
  for (let i = 0; i < arr.length; i++) {
    console.log(arr[i]);
  }
}

// const link = document.createElement('a');
// link.href = url;
// link.download = 'file.jpg';
// link.dispatchEvent(new MouseEvent('click'));
// document.getElementById("assets").getElementsByTagName("article")[0].getAttribute("data-thumb-url")
