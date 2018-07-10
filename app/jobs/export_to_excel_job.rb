class ExportToExcelJob < ApplicationJob
  #include ActionController::MimeResponds
  queue_as :default

  def perform(*args)
    # Do something later
    filename  = 'test_name'
    #respond_to do |format|
    #              format.html
    #              format.xlsx do
    #                response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"'
    #                render "testsidekiq.xlsx"
    #              end  
    #end
    #redirect_to "/admindashboard" ,notice: "You trying to access without permission role User!"
        
        render "testsidekiq.xlsx"
  end
end
