function parallax() {
	var scrollPosition = $(window).scrollTop();
	$('#parallax').css('top',(72 - (scrollPosition * 0.3))+'px' ); // bg image moves at 30% of scrolling speed
}

$(document).ready(function() {

	/* ========== PARALLAX BACKGROUND ========== */

	$(window).on('scroll', function(e) {
		parallax();
	});



	/* ========== FITVIDS PLUGIN ========== */
	
	//$('.fitvids').fitVids();



	/* ========== BOOTSTRAP CAROUSEL ========== */

	//$('.carousel').carousel({
	//  interval: 4000
	//});



	/* ========== BOOTSTRAP SCROLLSPY ========== */
	
	$('section').scrollspy();

	/* ========== SMOOTH SCROLLING BETWEEN SECTIONS ========== */

	$('[href^=#]').not('.carousel a, .panel a, .modal-trigger a').click(function (e) {
	  e.preventDefault();
	  var div = $(this).attr('href');

	  if ($(".navbar").css("position") == "fixed" ) {
		  $("html, body").animate({
		    scrollTop: $(div).position().top-72
		  }, 700, 'swing');
		} else {
			$("html, body").animate({
		    scrollTop: $(div).position().top
		  }, 700, 'swing');
		}
	});



	/* =========== CUSTOM STYLE FOR SELECT DROPDOWN ========== */

	$("select").selectpicker({style: 'btn-hg btn-primary', menuStyle: 'dropdown'});

	// style: select toggle class name (which is .btn)
	// menuStyle: dropdown class name

	// You can always select by any other attribute, not just tag name.
	// Also you can leave selectpicker arguments blank to apply defaults.



	/* ========== TOOLTIPS & POPOVERS =========== */

	$("[data-toggle=tooltip]").tooltip();

	$('.popover-trigger').popover('hide');

});


/* ========== ISOTOPE FILTERING ========== */

$(window).load(function(){

	var $container = $('#gallery-items'),
        $select = $('#filters select');

    $container.isotope({
        itemSelector: '.gallery-item'
    });

    $select.change(function() {
        var filters = $(this).val();
;
        $container.isotope({
            filter: filters
        });
    });
    
})
