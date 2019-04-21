/*
Instagram Veri Tasarımı
    Resim Alanı
        document.getElementsByTagName("article")[0].childNodes[0].childNodes[0];
    Class Yapısı
        flex-direction: column; padding-bottom: 336920px; padding-top: 0px;
        flex-direction: column; padding-bottom: 0px; padding-top: 337288px;
    Class Yapısı Yeni
        flex-direction: column; padding-bottom: 336444px; padding-top: 0px;
        flex-direction: column; padding-bottom: 336151px; padding-top: 0px;
        flex-direction: column; padding-bottom: 335858px; padding-top: 0px;
        flex-direction: column; padding-bottom: 335565px; padding-top: 0px;

        331881px

        293 px her sayfa için

        document.getElementsByTagName("article")[0].childNodes[0].childNodes[0].style.paddingBottom -= 293;

        ilkinde tam al
        document.getElementsByClassName("Nnq7C weEfm") 8. gözüken satır

        332703px
        329076px
        325573px

        ----
        335799px Başlangıç
        329364px 2. nin 0'ı

        335463px sayfaya gel
        document.getElementsByClassName("Nnq7C weEfm") ile çek

        335631px Başlangıç
        335339px
        335045px

        Y SCroll (321 her adım için)
        ---
        600 Başlangıç 580 de olur 7290
        document.getElementsByClassName("Nnq7C weEfm") ile çek
        321 * 12 = 3852 kay 9.öge

        1560
        1880
        2200

        580 - 7290

        Div Classı:
            293 perpage
            flex-direction: column; padding-top: 0px; padding-bottom: 335325px;
            flex-direction: column; padding-top: 0px; padding-bottom: 335032px;

            document.getElementsByClassName("FFVAD");


        document.getElementsByClassName("v1Nh3 kIKUG  _bz0w")[0].getBoundingClientRect().y = 62 olmalı
        window.scrollY ile heaspla

        321

        window.scrollBy(0, 321 * 11) 
        27'den başlar = (59 - 26) / 3

        Geçici = 17593

        Çıkarma

        16253 - 9889  / lenght
*/


// 33 te kayıyor
var i = 0;
window.scrollBy(0, 321);
if (i != 30) {
    i = i + 3;
} 
document.getElementsByClassName("FFVAD")[i];
    
function insertImgUrlsRowByRow(urls = [], initial = 0, delay = 300) {
    urls.push(document.getElementsByClassName("FFVAD")[initial].src);
    urls.push(document.getElementsByClassName("FFVAD")[initial + 1].src);
    urls.push(document.getElementsByClassName("FFVAD")[initial + 2].src);

    window.scrollBy(0, 321);

    if (initial != 30) {
        initial += 3;
    }

    scrolldelay = setTimeout(function() {
        insertImgUrlsRowByRow(urls, initial, delay);
    }, 1000);
}

function temp(delay = 1000) {
    window.scrollBy(0, 321);
    scrolldelay = setTimeout({
        temp(delay);
    }, delay);
}

// Son Durum
var INITIAL_HEIGHT = 580; // 3469; 2823
var NUM_IMG_IN_DIV = 3;
var FIRST_INDEX_IMAGE = 27; 

// Resim alanının başına kaydırma
// Başlangıçda 9 daha kaydır
window.scrollTo(0, INITIAL_HEIGHT); // window.scrollTo(0, 3469); -- 580

var imgs = document.getElementsByClassName("FFVAD");
// Length kadar kaydır. (Başlangıçta) 21 yada 27 / 3 de ekle

var imgRect1 = imgs[0].getBoundingClientRect()
var imgRect2 = imgs[3].getBoundingClientRect()

var gap = imgRect2.top - (imgRect1.top + imgRect1.height);
var distance = imgRect1.height + gap;

for (let i = 1; i < imgs.length / 3; i++) {
    window.scrollBy(0, distance); // 7290  - 6710 6739
}

function iniateScroll(callback) {
    window.scrollTo(0, INITIAL_HEIGHT);
}

function pageScroll(func, delay, loop = false) {
    func();
    window.scrollBy(0,321);
    if (loop) {
        scrolldelay = setTimeout(pageScroll(delay, loop), delay); // Gecikmeli tekrarlama
    }
}

function pageScroll(func, delay) {
    func();
    window.scrollBy(0,321);
    scrolldelay = setTimeout(pageScroll(undefined, delay), delay); // Gecikmeli tekrarlama
}
 
// Direk 20 mi yapılmalı??
/*

const INITIAL_HEIGHT = 580;
const PADDING_HEIGHT = 293;
const PAGE_HEIGHT = 321;
const EXACT_HEIGHT_MOVE = 6710;

// Resim alanının başına kaydırma
window.scrollTo(0, INITIAL_HEIGHT);

var imgDiv = document.getElementsByClassName("Nnq7C weEfm");
window.scrollBy(0, imgDiv.length * PAGE_HEIGHT);
window.scrollBy(0, 6710);




// Resim alanını değişkene atama
const imageDivision = document.getElementsByTagName("article")[0].childNodes[0].childNodes[0];

function getCollections(){
    const urls = [];
    const collections = document.getElementsByClassName("FFVAD");
    for (let i = 0; i < collections.length; i++) {
        const collection = collections[i];
        urls.push(collection.src)
    }
}

const pageSize = 1284;
var height = 97078;
for (let index = 0; index < 10; index++) {
    window.scrollTo(0,150000);
    console.log("H: ", document.body.scrollHeight);
}

function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds){
            break;
        }
    }
}
*/



