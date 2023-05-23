import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Invoice = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [borrower, setBorrower] = useState({ name: "" });
  const [invoice, setInvoice] = useState({ number: "", amount: 0.0, dueDate: "01/01/1970", status: "" });

  useEffect(() => {
    const url = `/api/v1/borrowers/${params.borrower_id}/invoices/show/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Error in connecting to the server.");
      })
      .then((response) => { setBorrower(response.borrower); setInvoice(response.invoice); })
      .catch(() => console.log(error.message));
  }, [params.id]);

  // Fees calcuation is not defined and so it is always 0.0 until defined at which point a new column needs to be added to the Invoice model to maintain this.
  const fees = () => {
    return 0.0;
  };

  const invoiceActions = () => {
    if (invoice.status === "CREATED") {
      return (
        <div>
          <Link to={`/borrower/${borrower.id}/invoice/${invoice.id}/approve`} className="btn custom-button">
            Approve
          </Link>
          <Link to={`/borrower/${borrower.id}/invoice/${invoice.id}/reject`} className="btn custom-button">
            Reject
          </Link>
        </div>
      );
    } else if (invoice.status === "APPROVED") {
      return (
        <div>
          <Link to={`/borrower/${borrower.id}/invoice/${invoice.id}/purchase`} className="btn custom-button">
            Purchase
          </Link>
        </div>
      );
    } else if (invoice.status === "REJECTED") {
      return (
        <div>
          There are no possible actions on a rejected invoice.
        </div>
      );
    } else if (invoice.status === "PURCHASED") {
      return (
        <div>
          <Link to={`/borrower/${borrower.id}/invoice/${invoice.id}/close`} className="btn custom-button">
            Close
          </Link>
        </div>
      );
    } else {
      return (
        <div>
          This invoice is closed.
        </div>
      );
    }
  };
  
  return (
    <div className="">
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">{borrower.name}</h1>
          <p className="lead text-muted">
            Invoice Number "{invoice.number}"
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="col-sm-12 col-lg-7">
            <h5 className="mb-2">Amount</h5>
            <div>
                {invoice.amount}
            </div>
          </div>
          <br></br>
          <div className="col-sm-12 col-lg-7">
            <h5 className="mb-2">Due Date</h5>
            <div>
                {invoice.dueDate}
            </div>
          </div>
          <br></br>
          <div className="col-sm-12 col-lg-7">
            <h5 className="mb-2">Fees</h5>
            <div>
                {fees()}
            </div>
          </div>
          <br></br>
          <div className="col-sm-12 col-lg-7">
            <h5 className="mb-2">Status</h5>
            <div>
                {invoice.status}
            </div>
          </div>
          <br></br>
          <br></br>
          <div className="text-end mb-3">
            <Link to={`/borrower/${borrower.id}`} className="btn btn-link" style={{float: "left", padding: "0px"}}>
              Back to {borrower.name}
            </Link>
            {invoiceActions()}
          </div>
        </main>
      </div>
    </div>
  );
};

export default Invoice;