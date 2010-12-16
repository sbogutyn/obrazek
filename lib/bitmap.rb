module Bitmap
  # Domyślna nazwa pliku z obrazkiem
  OBRAZEK = "plain.bmp"
  
  # Klasa do odczytu danych z bitmapy
  # TODO:
  # 1. Zapis danych do bitmapy
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

    # TODO:
    # Wielokrotnie odczytywany jest piksel 0,0, 
    # należy to poprawić.
    def wypisz_piksele
      nr_iteracji = 0
      znak = ""
      (0...@szerokosc).each do |szer|
        (0...@wysokosc).each do |wys|
          nr_iteracji += 1
          piksel = czytaj_bajty(@poczatek_obrazka + szer * wys, 1)
          case piksel
          when 0
            znak = "0"
          when 255
            znak = "1"
          end
          print znak # + " " * (4 - znak.length)
          print "\n" if nr_iteracji % @szerokosc == 0
        end
      end
    end

    # TODO:
    # Odczyt powoduje wyświetlenie parametrów obrazka
    # po znaku tabulacji. Powinien pokazywac dane na
    # początku danego wiersza.
    def to_s
      output =<<-DANE
      Plik: #{@plik}
      Rozmiar: #{@rozmiar_pliku}
      Szerokosc: #{@szerokosc}, wysokosc #{@wysokosc}
      Ilosc bitow: #{@ilosc_bitow}
      Poczatek obrazka: #{@poczatek_obrazka}
      Rozmiar naglowka: #{@rozmiar_naglowka}
      Rozmiar obrazka #{@rozmiar_obrazka}
      DANE
    end

    protected

    # Odczyt danych w postaci binarnej i skonwertowanie go do 
    # opdowiedniego rodzaju liczby (int, short lub char).
    def czytaj_bajty(offset, ilosc_bitow = 4)
      odczyt = IO.read(@plik, ilosc_bitow, offset)
      case ilosc_bitow
      when 4
        odczyt.unpack("I")[0]
      when 2
        odczyt.unpack("S")[0]
      when 1
        odczyt.unpack("C")[0]
      end
    end

  end
end


