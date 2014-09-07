class StatsController < ApplicationController
	before_filter :check_if_logged

	def operation_distribution
	end
	
	def operation_distribution_data
		#Operation.joins(:operation_classification).group('operation_classifications.wording').sum(:amount)
		#render :json => { :text => "Hello the world" }
		render :json => {
							:output => Operation.output.joins(:operation_classification).group('operation_classifications.wording').sum(:amount),
							:input => Operation.input.joins(:operation_classification).group('operation_classifications.wording').sum(:amount)
						}
		#render :json => { 	:label => "Legend",
		#					:dataBar => Operation.joins(:operation_classification).group('operation_classifications.wording').sum(:amount)
		#				}
	end
	
end