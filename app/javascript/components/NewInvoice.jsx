import React, { useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const NewInvoice = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [number, setNumber] = useState("");
  const [amount, setAmount] = useState("");
  const [dueDate, setDueDate] = useState("");

  const stripHtmlEntities = (str) => {
    return String(str)
      .replace(/\n/g, "<br> <br>")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
  };

  const onChange = (event, setFunction) => {
    setFunction(event.target.value);
  };

  const onSubmit = (event) => {
    event.preventDefault();
    const url = `/api/v1/borrowers/${params.borrower_id}/invoices/create`;

    if (number.length == 0 || amount.length == 0 || amount < 0.0 || dueDate.length == 0) {
      return;
    }

    const body = {
      number: stripHtmlEntities(number),
      amount,
      due_date: dueDate
    };

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Error in connecting to the server.");
      })
      .then((response) => navigate(`/borrower/${response.borrower_id}/invoice/${response.id}`))
      .catch((error) => console.log(error.message));
  };

  return (
    <div className="container mt-5">
      <div className="row">
        <div className="col-sm-12 col-lg-6 offset-lg-3">
          <h1 className="font-weight-normal mb-5">
            Add a new invoice.
          </h1>
          <form onSubmit={onSubmit}>
            <div className="form-group">
              <label htmlFor="invoiceNumber">Invoice Number:</label>
              <input
                type="text"
                name="number"
                id="invoiceNumber"
                className="form-control"
                required
                onChange={(event) => onChange(event, setNumber)}
              />
            </div>
            <br></br>
            <div className="form-group">
              <label htmlFor="invoiceAmount">Amount:</label>
              <input
                type="text"
                name="amount"
                id="invoiceAmount"
                className="form-control"
                required
                onChange={(event) => onChange(event, setAmount)}
              />
              <small id="amountHelp" className="form-text text-muted">
                Enter only up to 2 decimal places.
              </small>
            </div>
            <br></br>
            <div className="form-group">
              <label htmlFor="invoiceDueDate">Due Date: &nbsp;</label>
              <input
                type="date"
                name="dueDate"
                id="invoiceDueDate"
                min={new Date().toISOString().split("T")[0]}
                onChange={(event) => onChange(event, setDueDate)}
                required
              />
              <br></br>
              <small id="dueDateHelp" className="form-text text-muted">
                Date format is mm/dd/yyyy.
              </small>
            </div>
            <br></br>
            <button type="submit" className="btn custom-button mt-3">
              Create Invoice
            </button>
            <Link to={`/borrower/${params.borrower_id}`} className="btn btn-link mt-3">
              Back to invoices
            </Link>
          </form>
        </div>
      </div>
    </div>
  );
};

export default NewInvoice;