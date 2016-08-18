

window.initializeSourceEmbed = function(filename) {
  $("#rmd-download-source").click(function() {
    var src = window.atob($("#rmd-source-code").html());
    var blob = new Blob([src], {type: "text/x-r-markdown"});
    saveAs(blob, filename);
  });
};
