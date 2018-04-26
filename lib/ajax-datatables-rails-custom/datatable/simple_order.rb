# frozen_string_literal: true

module AjaxDatatablesRailsCustom
  module Datatable
    class SimpleOrder

      DIRECTIONS = ['DESC NULLS LAST' 'ASC']

      def initialize(datatable, options = {})
        @datatable = datatable
        @options   = options
      end

      def query(sort_column)
        "#{sort_column} #{direction}"
      end

      def column
        @datatable.column_by(:index, column_index)
      end

      def direction
        column_direction || 'ASC'
       #@options[:dir].upcase
       #DIRECTIONS.find { |dir| dir == column_direction } || 'ASC'
       #@DIRECTIONS.find { |dir| dir == column_direction } || 'ASC'
      end

      private

      def column_index
        @options[:column]
      end

      def column_direction
        @options[:dir].upcase
      end

    end
  end
end
