class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = Entry.all
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = current_member.entries.new(entry_params)
    if @entry.save
      redirect_to @entry
    else
      render :new
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to @entry
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
      @author = Member.find_by(id: @entry.member_id)
    end

    def entry_params
      params.require(:entry).permit(:name, :body)
    end
end
