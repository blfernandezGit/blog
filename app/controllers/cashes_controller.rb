class CashesController < ApplicationController
  before_action :set_cash, only: %i[ show edit update destroy ]

  # GET /cashes or /cashes.json
  def index
    @cashes = Cash.all
  end

  # GET /cashes/1 or /cashes/1.json
  def show
  end

  # GET /cashes/new
  def new
    @cash = Cash.new
  end

  # GET /cashes/1/edit
  def edit
  end

  # POST /cashes or /cashes.json
  def create
    @cash = Cash.new(cash_params)

    respond_to do |format|
      if @cash.save
        format.html { redirect_to @cash, notice: "Cash was successfully created." }
        format.json { render :show, status: :created, location: @cash }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cashes/1 or /cashes/1.json
  def update
    respond_to do |format|
      if @cash.update(cash_params)
        format.html { redirect_to @cash, notice: "Cash was successfully updated." }
        format.json { render :show, status: :ok, location: @cash }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cashes/1 or /cashes/1.json
  def destroy
    @cash.destroy
    respond_to do |format|
      format.html { redirect_to cashes_url, notice: "Cash was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash
      @cash = Cash.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cash_params
      params.require(:cash).permit(:balance, :last_cash_in_amt, :user_id)
    end
end
