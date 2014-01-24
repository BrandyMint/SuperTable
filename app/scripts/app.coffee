define [
  'underscore',
  'backbone',
  'models/table',
  'views/layout',
  'views/table',
  'collections/page',
  'services/page_fetching'
], (_, Backbone, TableModel, LayoutView, TableView, PageCollection, PageFetchingService) ->

  class App
    initialize: (options) ->
      _.extend @, Backbone.Events

      console.log 'app starting...'

      version='0.1.1'
      $('#app_version').text version

      unless options.pageUrl and options.tableUrl
        console.log 'url is a mandatory parameter'
        return false

      el = options.el || 'body'

      pages = new PageCollection()
      table = new TableModel({}, {url: options.tableUrl})
      table.set 'pages', pages
      tableView = new TableView(model: table, collection: pages)
      layoutView = new LayoutView(app: @, el: el, table: tableView)

      layoutView.render()

      pageFetchingService = new PageFetchingService
        app: @
        table: table
        collection: pages
        pageUrl: options.pageUrl

      pageFetchingService.getPage(0)
      pageFetchingService.getPage(1)
