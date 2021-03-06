class IssuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find params[:id]
    @propositions = @issue.propositions.sort(params[:propositions_order]).limit(10)
    @propositions_order = params[:propositions_order]
    @statuses = @issue.statuses.all
    @new_comment = @issue.comments.new
  end

  def new
    @issue = Issue.new
    proposition_id = params[:related_proposition_id]
    if proposition_id.present?
      @related_proposition = Proposition.find proposition_id
      @related_issue = @related_proposition.issue
    end
  end

  def create
    @issue = Issue.new(create_params)
    if create_params[:related_proposition_id].present?
      @issue.related_proposition = Proposition.find create_params[:related_proposition_id]
    end
    @issue.user = current_user
    if @issue.save
      redirect_to @issue
    else
      render 'new'
    end
  end

  def fork
    @issue = Issue.find params[:id]
    @copy = @issue.fork
    @copy.parent_issue = @issue
    @copy.save!
    redirect_to @copy
  end

  private

  def create_params
    params.require(:issue).permit([:title, :related_proposition_id])
  end
end
