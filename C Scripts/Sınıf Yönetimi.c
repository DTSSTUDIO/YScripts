#include <stdio.h>
#include <math.h>

typedef struct {
	// Kimlik bilgileri
	char* adi;
	char* soyadi;
	
	// Sinav bilgileri
	int arasinav1;
	int arasinav2;
	int final;
	
	int notu;
	char* harf;
	char* durumu;
} Kayit;


int enDusukNot();
int enYuksekNot();
float sinifOrtalamasi();
float standartSapma();

void istatistikiBilgiler();
void kayitlariBasariNotunaGoreSirala();
void sinifBasariNotlariniHesapla();
void kayitEkle();
void kayitlariListele();
void menuYaz();


Kayit sinif[10];
int sayac = 0;

int main() {
	menuYaz();
}

// Ekrana menuyu yazar
void menuYaz() {
	// Secim degiskeni
	int secim;
	
	// Arayuz dongusu
	while (1) {
		printf("MENU\n");
		printf("1-Kayit Ekle\n");
		printf("2-Kayitlari Listele\n");
		printf("3-Sinif basari notlarini hesapla\n");
		printf("4-Kayitlari basari notune gore sirala\n");
		printf("5-Istatistiki bilgiler\n");
		printf("6-Cikis\n");
		printf("Bir islem seciniz: ");
		
		// Girdiyi alma
		scanf("%d", &secim);
		
		switch(secim) {
			case 1:
				kayitEkle();
				break;
			case 2:
				kayitlariListele();
				break;
			case 3:
				sinifBasariNotlariniHesapla();
				break;
			case 4:
				kayitlariBasariNotunaGoreSirala();
				break;
			case 5:
				istatistikiBilgiler();
				break;
			case 6:
				return;
		}
	}
	
}

void kayitEkle() {
	// En fazla 10 ogrenci olmali
	if (sayac < 10) {
		// Adi verisini alma (sayac ogrenci sayisini tutuyor)
		printf("Adi: ");
		scanf("%s", &(sinif[sayac].adi));
		
		// Soyadi verisini alma
		printf("Soyadi ");
		scanf("%s", &(sinif[sayac].soyadi));
		
		// Sinav verilerini alma
		printf("1.Ara Sinav 2.Ara Sinav Final: ");
		scanf("%d %d %d", &(sinif[sayac].arasinav1), &(sinif[sayac].arasinav2), &(sinif[sayac].final));
			
		// String tuttugumuz icin char*'larin adresini veriyoruz
		printf("Kayit Verileri: %s %s %d %d %d \n", &(sinif[sayac].adi), &(sinif[sayac].soyadi), sinif[sayac].arasinav1, sinif[sayac].arasinav2, sinif[sayac].final);
		
		// Sayaci 1 arttiriyoruz ki 10'dan fazla ekleme olmasin
		sayac++;
	} else {
		printf("Sinif mevcudu dolu!\n");
	}
}

void kayitlariListele() {
	// Dongu olusturma
	int i;
	printf("%-7s %-5s %-5s %-5s %-5s %-4s %-4s %-7s \n", "Ad", "Soyad", "Vize1", "Vize2", "Final", "Notu", "Harf", "Durumu");
	for (i = 0; i < sayac; i++) {
		printf("%-7s %-5s %-5d %-5d %-5d %-4d %-4s %-7s \n", &(sinif[i].adi), &(sinif[i].soyadi), sinif[i].arasinav1, sinif[i].arasinav2, sinif[i].final, sinif[i].notu, sinif[i].harf, sinif[i].durumu);
	}
}

void sinifBasariNotlariniHesapla() {
	// Sayac 0 ise kisi eklenmemis demektir
	if (sayac == 0) {
		printf("Kisi eklemeden basari notu hesaplanamaz!\n");
		printf("Sinif kayit ekranindan kayit ekleme islemi gerceklesitiriniz!");
	} else {
		// Her kayit icin basari notunu hesaplama (i sayactan k�c�k oldugu s�rece devam edecek)
		int i;
		for (i = 0; i < sayac; i++) {
			float not = (sinif[i].arasinav1 * 20.0 / 100 + sinif[i].arasinav2 * 30.0 / 100 + sinif[i].final * 50.0 / 100);
			
			// Virgulden sonraki sayiyi kontrol etme
			// Orn: 13.4 ise 13.4 x 10 = 134  
			// 134 % 10 = 4
			// 4 < 5 yani asagi yuvarlayacagiz.
			// (int) ile takiladigimizda kusurat kaybolur asagi yuvarlanmis olur
			if (((int)(not * 10) % 10) < 5) {
				sinif[i].notu = (int)not;
			} else {
				// Asagi yuvarladiktan sonra 1 eklersek, yukari yuvarlamis oluruz
				sinif[i].notu = (int)not + 1;
			}
			
			// Not ortalamasi hesaplama
			if (sinif[i].notu > 89) {
				sinif[i].harf = "AA";
			} else if (sinif[i].notu > 84) {
				sinif[i].harf = "BA";
			} else if (sinif[i].notu > 79) {
				sinif[i].harf = "BB";
			} else if (sinif[i].notu > 74) {
				sinif[i].harf = "CB";
			} else if (sinif[i].notu > 69) {
				sinif[i].harf = "CC";
			} else if (sinif[i].notu > 64) {
				sinif[i].harf = "DC";
			} else if (sinif[i].notu > 59) {
				sinif[i].harf = "DD";
			} else if (sinif[i].notu > 49) {
				sinif[i].harf = "FD";	
			} else {
				sinif[i].harf = "FF";
			} 
			
			// Basari durumu hesaplama
			if (sinif[i].harf == "FF") {
				sinif[i].durumu = "KALDI";
			} else if (sinif[i].harf == "FD") {
				sinif[i].durumu = "Sartli Gecti";
			} else {
				sinif[i].durumu = "Gecti";
			}
		}
	}
}

void kayitlariBasariNotunaGoreSirala() {
	// Dongu olusturma
	int i, j;
	for (i = 0; i < sayac; i++) {
		// Ust sayactan (i'den) daha sonraki verileri kontrol etmemiz gerekmekte (oncesi siralanmistir zaten)
		for (j = i + 1; j < sayac; j++) {
			// Eger ikinci bakilan ilk bakilandan buyukse yer degistir
			if (sinif[j].notu > sinif[i].notu) {
				// Verinin kaybolmamasi icin gecici degiskende sakliyoruz
				Kayit gecici = sinif[i];
				sinif[i] = sinif[j];
				sinif[j] = gecici;
			}
		}
	}
	
	kayitlariListele();
}

void istatistikiBilgiler() {
	printf("---Istatistiki Bilgiler---\n");
	printf("En Yuksek Not: %d \n", enYuksekNot());
	printf("En Dusuk Not: %d \n", enDusukNot());
	printf("Sinif Ortalamasi: %f \n", sinifOrtalamasi());
	printf("Ortalama Uzerinde Olan Kisi Sayisi: %d \n", ortalamaUzerindeOlanKisiSayisi());
	printf("Standart Sapma: %f \n", standartSapma());
}

int enYuksekNot() {
	// Varsayilan degeri en dusuk not yapiyoruz
	int not = 0;
	
	// Dongu baslatma
	int i;
	for (i = 0; i < sayac; i++) {
		// Eger kisinin notu bizim notumuzdan yuksek ise kisinin notunu en yuksek olarak tutma
		if (not < sinif[i].notu) {
			not = sinif[i].notu;
		}
	}
	
	// En yuksek notu dondurme
	return not;
}

int enDusukNot() {
	// Varsayilan degeri en yuksek not yapiyoruz
	int not = 100;
	
	// Dongu baslatma
	int i;
	for (i = 0; i < sayac; i++) {
		// Eger kisinin notu bizim notumuzdan dusuk ise kisinin notunu en dusuk olarak tutma
		if (not > sinif[i].notu) {
			not = sinif[i].notu;
		}
	}
	
	// En dusuk notu dondurme
	return not;
}

float sinifOrtalamasi() {
	// Ortalama hesaplamak icin
	float ortalama = 0;
	
	// Dongu baslatma
	int i;
	for (i = 0; i < sayac; i++) {
		ortalama += sinif[i].notu;
	}
	
	return ortalama / sayac;
}

int ortalamaUzerindeOlanKisiSayisi() {
	// Kisi sayisinin tutulacagi degisken
	int kisiSayisi = 0;
	
	// Dongu olusturma
	int i;
	for (i = 0; i < sayac; i++) {
		// Ortalamadan yuksekse kisi sayisini 1 arttirma
		if (sinif[i].notu > sinifOrtalamasi()) {
			kisiSayisi++;
		}
	}
	
	// Kisi sayisini dondurme
	return kisiSayisi;
}

float standartSapma() {
	// Sapma hesaplamak icin ek degisken
	float karelerToplami = 0;
	
	// Dongu baslatma
	int i;
	for (i = 0; i < sayac; i++) {
		// Farkinin karesini alip kareler toplamina ekleme
		karelerToplami += pow((sinif[i].notu - sinifOrtalamasi()), 2);
	}
	
	// Standart sapmayi dondurme
	return sqrt(karelerToplami / (sayac - 1));
}
