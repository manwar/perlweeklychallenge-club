
  use GD;
  use JSON;
  use OCR::OcrSpace;
  
  sub write_image{
      my($s) = @_;
      my $width = 500;
      my $height = 500;
      my $image_file = q#/tmp/output_image.png#;
      my $image = GD::Image->new($width, $height);
      my $white = $image->colorAllocate(255, 255, 255);  
      my $black = $image->colorAllocate(0, 0, 0);        
      $image->filledRectangle(0, 0, $width - 1, $height - 1, $white);
      my $font_path = q#/System/Library/Fonts/Courier.ttc#;
      my $font_size = 14;
      $image->stringFT($black, $font_path, $font_size, 0, 10, 50, $s);
      open TEMP, q/>/, qq/$image_file/;
      binmode TEMP;
      print TEMP $image->png;
      close TEMP;
      return $image_file;
  }

  
  sub counter_integers{
      my($s) = @_;
      my @numbers;
      
  $s =~ tr/a-z/ /;

      my $image = write_image($s);
      my $ocrspace = OCR::OcrSpace->new(); 
      my $ocrspace_parameters = {  file      => qq/$image/,  
                                   apikey    => q/K89345674088957/,
                                   filetype  => q/PNG/,
                                   scale     => q/True/,
                                   isOverlayRequired => q/True/,
                                   OCREngine => 2};
      my $result = $ocrspace->get_result($ocrspace_parameters);
      $result = decode_json($result); 
      my $lines = $result->{ParsedResults}[0]
                     ->{TextOverlay}
                     ->{Lines};
      for my $line (@{$lines}){
          for my $word (@{$line->{Words}}){
              push @numbers, $word->{WordText};
          }
      }
      return join q/, /, @numbers;
  }

  
MAIN:{
    print counter_integers q/the1weekly2challenge2/;
    print qq/\n/;
    print counter_integers q/go21od1lu5c7k/;
    print qq/\n/;
    print counter_integers q/4p3e2r1l/;
    print qq/\n/;
} 

