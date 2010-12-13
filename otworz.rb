#!/usr/bin/env ruby
# otworzyc plik bmp czarno bialy i odczytac dane o jego piskelach do tablicy
OBRAZEK = "plain.bmp"

class Bitmapa
  def initialize(nazwa_pliku)
    @plik = nazwa_pliku
    @rozmiar_pliku = czytaj_bajty(2)
    @szerokosc = czytaj_bajty(18)
    @wysokosc =  czytaj_bajty(22)
    @ilosc_bitow = czytaj_bajty(28, 2)
    @poczatek_obrazka = czytaj_bajty(10)
    @rozmiar_naglowka = czytaj_bajty(14)
    @rozmiar_obrazka = czytaj_bajty(34)
  end

  def czytaj_bajty(offset, ilosc_bitow = 4)
    case ilosc_bitow
    when 4
      IO.read(@plik, ilosc_bitow, offset).unpack("I")[0]
    when 2
      IO.read(@plik, ilosc_bitow, offset).unpack("S")[0]
    when 1
      IO.read(@plik, ilosc_bitow, offset).unpack("C")[0]
    end
  end

  def wypisz_piksele
    tablica = {}
    (0...@szerokosc).each do |szer|
      (0...@wysokosc).each do |wys|
        print czytaj_bajty(@poczatek_obrazka + szer * wys, 1).to_s + " "
      end
    end
  end


  def zapisz_czarny
    
  end

  def to_s
    output =<<-DANE
    Rozmiar pliku: #{@rozmiar_pliku}
    Szerokosc: #{@szerokosc}, wysokosc #{@wysokosc}
    Ilosc bitow: #{@ilosc_bitow}
    Poczatek obrazka: #{@poczatek_obrazka}
    Rozmiar naglowka: #{@rozmiar_naglowka}
    Rozmiar obrazka #{@rozmiar_obrazka}
    DANE
  end
end


obrazek = Bitmapa.new(OBRAZEK)
puts obrazek  
obrazek.wypisz_piksele

