$(document).on('turbolinks:load', function() {
    $pixelConv = tinycolor(color).complement().toHexString();
    $bandana = tinycolor(color).complement().toHexString();
    $bandanaConv = tinycolor(old_color).complement().toHexString();
    $('.home audio').trigger('load');
    $('head').append('<style>.bandana { background-color: ' + $bandana + '} .btn-cta, .btn-cta-2 {background-color: ' + $bandana + '} .converted .bandana {background-color: ' + old_color + '!important }.converted .pixel:before {background: ' + $pixelConv + '; } .converted .btn-cta {background-color: ' + old_color + '!important } .pixel{ background-color: '+ color +'}</style>');

    if (converting === 'true') {
        $('body').addClass('converted');
        $(".wololo").trigger('play');
    }

    $('.btn-cta').on('click', function () {
        $('body').addClass('converted');
        $('.flip-container').toggleClass('hover');
    })
});
