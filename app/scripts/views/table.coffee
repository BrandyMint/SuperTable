define ['backbone', 'views/page'], (Backbone, PageView) ->
  class TableView extends Backbone.View
    itemView: PageView
    initialize: ->
      if @collection
        @listenTo @collection, 'add', @addItem
        @listenTo @collection, 'remove', @removeItem
        @listenTo @collection, 'reset', @resetCollection
      @views = {}
        
    render: ->
      @resetCollection()
      @collection.each @addItem
      @

    addItem: (model) =>
      view = new @itemView(model: model)
      @$el.append view.render().el
      @views[model] = view

    removeItem: (model) ->
      @views[model].remove()
      delete @views[model]

    resetCollection: ->
      @$el.empty()
      @views = {}
