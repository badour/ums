/* ============================================
   UMS ERP - Theme JavaScript
   Sidebar, navigation, and UI interactions
   ============================================ */

(function ($) {
    'use strict';

    var UMS = {
        init: function () {
            this.sidebar();
            this.sidebarMenu();
            this.tooltips();
            this.activeMenu();
            this.rtlToggle();
        },

        sidebar: function () {
            var $body = $('body');
            var $sidebar = $('.sidebar');
            var $overlay = $('.sidebar-overlay');

            $('.sidebar-toggle').on('click', function (e) {
                e.preventDefault();
                if ($(window).width() < 992) {
                    $sidebar.toggleClass('show');
                    $overlay.toggle();
                } else {
                    $body.toggleClass('sidebar-collapsed');
                }
                localStorage.setItem('sidebar-collapsed', $body.hasClass('sidebar-collapsed'));
            });

            $overlay.on('click', function () {
                $sidebar.removeClass('show');
                $overlay.hide();
            });

            if ($(window).width() >= 992 && localStorage.getItem('sidebar-collapsed') === 'true') {
                $body.addClass('sidebar-collapsed');
            }
        },

        sidebarMenu: function () {
            $('.sidebar-menu .menu-link[data-toggle="submenu"]').on('click', function (e) {
                e.preventDefault();
                var $parent = $(this).parent('.menu-item');
                $parent.siblings('.menu-item.open').removeClass('open');
                $parent.toggleClass('open');
            });
        },

        tooltips: function () {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (el) {
                return new bootstrap.Tooltip(el);
            });
        },

        activeMenu: function () {
            var currentPage = window.location.pathname.split('/').pop().toLowerCase();
            if (!currentPage) currentPage = 'default.aspx';

            $('.sidebar-menu .menu-link').each(function () {
                var href = $(this).attr('href');
                if (href) {
                    var linkPage = href.split('/').pop().toLowerCase();
                    if (linkPage === currentPage) {
                        $(this).addClass('active');
                        $(this).closest('.menu-item').parents('.menu-item').addClass('open');
                    }
                }
            });
        },

        rtlToggle: function () {
            $('#rtlToggle').on('click', function (e) {
                e.preventDefault();
                var $html = $('html');
                var isRtl = $html.attr('dir') === 'rtl';

                if (isRtl) {
                    $html.attr('dir', 'ltr').attr('lang', 'en');
                    $('#bootstrapCss').attr('href', 'assets/lib/bootstrap/bootstrap.min.css');
                } else {
                    $html.attr('dir', 'rtl').attr('lang', 'ar');
                    $('#bootstrapCss').attr('href', 'assets/lib/bootstrap/bootstrap.rtl.min.css');
                }
                localStorage.setItem('dir', $html.attr('dir'));
            });

            var savedDir = localStorage.getItem('dir');
            if (savedDir === 'rtl') {
                $('html').attr('dir', 'rtl').attr('lang', 'ar');
                $('#bootstrapCss').attr('href', 'assets/lib/bootstrap/bootstrap.rtl.min.css');
            }
        }
    };

    $(document).ready(function () {
        UMS.init();
    });

    window.UMS = UMS;

})(jQuery);

/* ---- Toastr Defaults ---- */
if (typeof toastr !== 'undefined') {
    toastr.options = {
        closeButton: true,
        progressBar: true,
        positionClass: 'toast-top-right',
        timeOut: 3000,
        extendedTimeOut: 1000,
        showEasing: 'swing',
        hideEasing: 'linear',
        showMethod: 'fadeIn',
        hideMethod: 'fadeOut'
    };
}

/* ---- Helper Functions ---- */
function confirmDelete(message, callback) {
    Swal.fire({
        title: 'Are you sure?',
        text: message || 'This action cannot be undone.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e74a3b',
        cancelButtonColor: '#718096',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
    }).then(function (result) {
        if (result.isConfirmed && typeof callback === 'function') {
            callback();
        }
    });
}

function showSuccess(message) {
    toastr.success(message);
}

function showError(message) {
    toastr.error(message);
}

function showInfo(message) {
    toastr.info(message);
}

function showWarning(message) {
    toastr.warning(message);
}

function initDataTable(selector, options) {
    var defaults = {
        responsive: true,
        pageLength: 10,
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, 'All']],
        language: {
            search: '',
            searchPlaceholder: 'Search...',
            lengthMenu: 'Show _MENU_ entries',
            info: 'Showing _START_ to _END_ of _TOTAL_ entries',
            paginate: { previous: '<i class="fas fa-chevron-left"></i>', next: '<i class="fas fa-chevron-right"></i>' }
        },
        dom: '<"row"<"col-sm-6"l><"col-sm-6"f>>rtip'
    };
    return $(selector).DataTable($.extend(true, {}, defaults, options || {}));
}
