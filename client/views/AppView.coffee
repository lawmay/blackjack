class window.AppView extends Backbone.View

  chips: 100

  className: 'container'

  template: _.template '
      <div class="game-info">
        <div class="gameHead">Blackjack</div>
        <div class="chips-container">Chips<div class="chips"></div></div>
        <div class="result-container"><span class="result"></span></div>
        <div class="button-container">
          <button class="hit-button">Hit</button>
          <button class="stand-button">Stand</button>
          <button class="new-game-button">New Game</button>
        </div>
      </div>
      <div class="hand-box">
        <div class="dealer-hand-container"></div>
        <div class="player-hand-container"></div>
      </div>
  '
  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> @model.initialize(); @render(); @checkInstaWin()

  checkInstaWin: =>
    @model.checkInstaWin()

  disableButtons: =>
    @$('.stand-button').attr('disabled', 'disabled')
    @$('.hit-button').attr('disabled', 'disabled')

  playerWin : =>
    @$('.result').html('')
    @$('.result').append("Player Wins!")
    @disableButtons()
    @chips += 20;
    @$('.chips').html(@chips);

  dealerWin : =>
    @$('.result').html('')
    @$('.result').append("Dealer Wins!")
    @disableButtons()
    @$('.chips').html(@chips);

  tie: =>
    @$('.result').html('')
    @$('.result').append("Push!")
    @chips += 10;
    @$('.chips').html(@chips);
    @disableButtons()

  initialize: =>
    @render()
    @$('.result').html('')
    @model.on "playerWin", => @playerWin()
    @model.on "dealerWin", => @dealerWin()
    @model.on "roundOver", => @disableButtons()
    @model.on "instaWin", => @playerWin()
    @model.on "tie", => @tie()
    console.log @chips

  render: ->
    @chips -= 10;
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.chips').html(@chips);
