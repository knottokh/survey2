# frozen_string_literal: true
#!/usr/bin/env ruby
module AjaxDatatablesRailsCustom
  require 'ajax-datatables-rails-custom/version'
  require 'ajax-datatables-rails-custom/config'
  require 'ajax-datatables-rails-custom/base'
  require 'ajax-datatables-rails-custom/datatable/datatable'
  require 'ajax-datatables-rails-custom/datatable/simple_search'
  require 'ajax-datatables-rails-custom/datatable/simple_order'
  require 'ajax-datatables-rails-custom/datatable/column/search'
  require 'ajax-datatables-rails-custom/datatable/column/order'
  require 'ajax-datatables-rails-custom/datatable/column/date_filter' unless AjaxDatatablesRailsCustom.old_rails?
  require 'ajax-datatables-rails-custom/datatable/column'
  require 'ajax-datatables-rails-custom/orm/active_record'
end
