part of ice_test;

download_tests() {
  group("Download", () {
    var editor;

    setUp((){
      editor = new Full(enable_javascript_mode: false)
        ..store.storage_key = "ice-test-${currentTestCase.id}";
    });

  	tearDown(() {
      document.query('#ice').remove();
      editor.store..clear()..freeze();
    });

    test("it downloads the source as a file", (){
      _test(_) {
        helpers.createProject(
          "Downloadable one",
	        content: "This is some content, all right.",
	        editor: editor
        );

        helpers.click('button', text: '☰');
        var el = helpers.queryWithContent("a", "Download");

        expect(el, isNotNull);
        expect(el.download, equals("Downloadable one"));
        expect(el.href, startsWith("blob:"));
      }
      editor.editorReady.then(expectAsync1(_test));
    });

    test("closes the main menu", () {
      _test(_) {
        helpers.createProject("My Downloadable Project");
        helpers.click('button', text: '☰');
        helpers.click('a', text: 'Download');

        expect(queryAll('li'), helpers.elementsAreEmpty);
      }
      editor.editorReady.then(expectAsync1(_test));
    });
  });
}
