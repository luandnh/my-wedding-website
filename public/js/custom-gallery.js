function initializeGallery() {
  // 1. Khởi tạo Isotope cho bố cục lưới (masonry layout)
  const $grid = $(".gallery-container").isotope({
    itemSelector: ".grid",
    layoutMode: "masonry",
    percentPosition: true,
    masonry: {
      columnWidth: ".grid",
    },
  });

  // Tải lại layout sau khi tất cả hình ảnh đã được tải xong
  $grid.imagesLoaded().progress(function () {
    $grid.isotope("layout");
  });

  // 2. Khởi tạo Fancybox cho hiệu ứng lightbox
  $(".fancybox").fancybox({
    padding: 0,
    openEffect: "elastic",
    closeEffect: "elastic",
    helpers: {
      title: {
        type: "inside",
      },
      overlay: {
        css: {
          background: "rgba(0,0,0,0.8)",
        },
      },
    },
  });
}
