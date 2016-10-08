$(document).on('turbolinks:load', function() {

    $oldColor = color
    $oldBandanaColor = tinycolor($oldColor).complement().toHexString()

    $newColor = new_color
    $newBandanaColor = tinycolor($newColor).complement().toHexString()

    $('.home audio').trigger('load');

    $('head').append('<style>'+
        '.pixel{ background-color: '+ $oldColor +'}'+
        '.bandana { background-color: ' + $oldBandanaColor + '}'+
        '.btn-cta, .btn-cta-2 {background-color: ' + $oldBandanaColor + '}'+
        '.converted .bandana {background-color: ' + $newBandanaColor + '!important }'+
        '.converted .pixel:before {background: ' + $newColor + '; }'+
        '.converted .btn-cta {background-color: ' + $newBandanaColor + '!important }'+
    '</style>');

    if (converting === 'true') {
        $('body').addClass('converted');
        $(".wololo").trigger('play');
    }

    $('.btn-cta').on('click', function () {
        $('body').addClass('converted');
        $('.flip-container').toggleClass('hover');
    })
});
