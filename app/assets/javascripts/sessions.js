$(document).on('turbolinks:load', function() {
    $pixelConv = tinycolor(pixel).complement().toHexString();
    $bandana = tinycolor(pixel).complement().toHexString();
    $bandanaConv = tinycolor($bandana).complement().toHexString();
    $('.home audio').trigger('load');
    $('head').append('<style>.bandana { background-color: ' + $bandana + '} .btn-cta, .btn-cta-2 {background-color: ' + $bandana + '} .converted .bandana {background-color: ' + $bandanaConv + '!important }.converted .pixel:before {background: ' + $pixelConv + '; } .converted .btn-cta {background-color: ' + $bandanaConv + '!important } .pixel{ background-color: '+ pixel +'}</style>');
});
