require 'spec_helper'

describe Poker do

  describe ".winning_hand" do

    context "input validation" do
      it "raises an error when hand1 contains less than 5 cards" do
        hand1 = [4, 2, 6, 8]
        hand2 = [2, 5, 3, 7, 6]
        expect { Poker.winning_hand(hand1, hand2) }.should raise_exception
      end
      it "raises an error when hand1 contains more than 5 cards" do
        hand1 = [4, 2, 6, 8, 7, 10]
        hand2 = [2, 5, 3, 7, 6]
        expect { Poker.winning_hand(hand1, hand2) }.should raise_exception
      end
      it "returns a useful exception message regarding the hand length" do
        hand1 = [4, 2, 6, 8]
        hand2 = [2, 5, 3, 7, 6]
        begin
          Poker.winning_hand(hand1, hand2)
        rescue StandardError => e
          e.message.should include("The hands must contain #{Poker::HAND_LENGTH} cards")
        end
      end

      it "raises an exception when a bad card value is present in the card array" do
        hand1 = ['J', 'Q', 'K', 'A']
        hand2 = [1, 2, 3, 4, 'P']
        expect { Poker.winning_hand(hand1, hand2) }.should raise_exception
      end

      it "raises an exception when a bad card value is present in the card array" do
        hand1 = ['J', 'Q', 'K', 'A']
        hand2 = [1, 2, 3, 4, 11]
        expect { Poker.winning_hand(hand1, hand2) }.should raise_exception
      end

      it "raises an exception when a bad card value is present in the card array" do
        hand1 = ['J', 'Q', 'K', 'A']
        hand2 = [1, 2, 3, 4, 'P']
        begin
          Poker.winning_hand(hand1, hand2)
        rescue StandardError => e
          e.message.should include("The following input was not valid: 'P'")
        end
      end
    end

    context "when the high card wins" do

      it "returns hand1, which has an 8" do
        hand1 = [4, 2, 6, 8, 3]
        hand2 = [2, 5, 3, 7, 6]
        Poker.winning_hand(hand1, hand2).should == hand1
      end

      context "when the hands contain face cards" do
        it "returns hand2, which has a King" do
          hand1 = [4, 2, 6, 8, 9]
          hand2 = [2, 5, 3, 7, 'K']
          Poker.winning_hand(hand1, hand2).should == hand2
        end

        it "returns hand1, which has a Queen" do
          hand1 = [4, 2, 6, 8, 'Q']
          hand2 = [2, 5, 3, 7, 'J']
          Poker.winning_hand(hand1, hand2).should == hand1
        end

        it "returns hand1, which has an Ace" do
          hand1 = [2, 5, 3, 7, 'J']
          hand2 = ['A', 2, 6, 8, 3]
          Poker.winning_hand(hand1, hand2).should == hand2
        end
      end

    end

    context "when the hand has a pair" do

      it "returns hand1, which has an pair of 2's" do
        hand1 = [2, 2, 3, 7, 5]
        hand2 = ['A', 1, 6, 8, 2]
        Poker.winning_hand(hand1, hand2).should == hand1
      end

    end

  end

end