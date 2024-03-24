actor Hesap_makinesi {

  var hucre : Int = 0;

  // toplama
  public func toplama(n : Int) : async Int {
    hucre += n;
    hucre;
  };

  // çıkarma
  public func cikarma(n : Int) : async Int {
    hucre -= n;
    hucre;
  };

  // çarpma
  public func carpma(n : Int) : async Int {
    hucre *= n;
    hucre;
  };

  // bölme
  public func bolme(n : Int) : async ?Int {
    if (n == 0) {
    
      return null;
    } else {
      hucre /= n;
      return ?hucre;
    };
  };

  public func temizle() : async () {
    hucre := 0;
  };
};
