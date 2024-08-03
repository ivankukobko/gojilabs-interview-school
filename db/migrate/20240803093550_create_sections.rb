class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :teacher_subject, null: false, foreign_key: true
      t.boolean :dow_mon, default:false
      t.boolean :dow_tue, default:false
      t.boolean :dow_wed, default:false
      t.boolean :dow_thu, default:false
      t.boolean :dow_fri, default:false
      t.time :start_at, null: false
      t.time :end_at, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
